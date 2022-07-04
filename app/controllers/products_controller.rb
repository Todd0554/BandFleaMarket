class ProductsController < CartProductsController
  
  before_action :set_product, only: %i[ show edit update destroy place_order ]
  before_action :set_page, only: %i[ index show_by_sort show_by_category ]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :show_by_sort, :show_by_category ]
  before_action :set_form_vars
  before_action :current_cart, except: %i[ index show_by_sort show_by_category show  ]
  # GET /products or /products.json

  # set the limited number of products shown in each page
  NUMBER_PRODUCTS_PER_PAGE = 5
  def index
    @products = Product.all
    # let each page only show 5 products
    @products_per_page = Product.offset(@page * NUMBER_PRODUCTS_PER_PAGE).limit(NUMBER_PRODUCTS_PER_PAGE)
    # if the user signed in give the user his cart, so the user can add the product directly in this page
    if user_signed_in?
      current_cart
    end
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    @product.category = @product.sort.category
  end


  # show the products under same sort
  def show_by_sort
    # find the sort params
    @find_sort = @sorts.find do |s|
      s[:id] == params[:id].to_i
    end
    # select the products of this sort
    @find_products_by_sort = Product.where(sort_id:@find_sort.id)
    @find_products_per_page = @find_products_by_sort.offset(@page * NUMBER_PRODUCTS_PER_PAGE).limit(NUMBER_PRODUCTS_PER_PAGE)
    # if the user signed in give the user his cart, so the user can add the product directly in this page
    if user_signed_in?
      current_cart
    end
  end

  # show the products under same category 
  def show_by_category
    @find_category = @categories.find do |c|
      c[:id] == params[:id].to_i
    end
    @find_products_by_category = Product.where(category_id: @find_category.id)
    @find_products_per_page = @find_products_by_category.offset(@page * NUMBER_PRODUCTS_PER_PAGE).limit(NUMBER_PRODUCTS_PER_PAGE)
    # if the user signed in give the user his cart, so the user can add the product directly in this page    
    if user_signed_in?
      current_cart
    end

  end
  
  # POST /products or /products.json
  def create
    @product = Product.new(product_params)
    @product.user = current_user
    @product.category = @product.sort.category
    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    @product.category = @product.sort.category
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  # place the order with product_id, buyer_id and seller_id
  def place_order
    Order.create(
      product_id: @product.id,
      buyer_id: current_user.id,
      seller_id: @product.user_id
    )
    # if the product is bought, the sold will become into true. Then other customers can't buy it again.
    @product.sold = true
    @product.save
    redirect_to order_success_path
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end
  
    # set the initial page number
    def set_page    
      @page = params.fetch(:page, 0).to_i
    end

    # set the instance varables
    def set_form_vars
      @categories = Category.all
      @sorts = Sort.all
    end
    # authorize control
    def authorize_user
      if current_user.id != @product.user_id
        flash[:alert] = "You can't do that!"
        redirect_to products_path
      end
    end

    # let the cart connect with current user, when a user signed in. if it is the first time for a user to sign in, just create a new cart withi this user's id.
    def current_cart
      if session[:cart_id] != nil
        cart = Cart.find_by(user_id: current_user.id)
        if cart.present?
          @current_cart = cart
        else
          session[:cart_id] = nil
        end
      end
      if session[:cart_id] == nil
        @current_cart = Cart.create(user_id: current_user.id)
        session[:cart_id] = @current_cart.id
      end
    end
    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:title, :description, :user_id, :sold, :price, :category_id, :picture, :sort_id)
    end
    
end