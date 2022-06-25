class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_form_vars
  # GET /products or /products.json

  NUMBER_PRODUCTS_PER_PAGE = 5

  def index
    @products = Product.all
    @page = params.fetch(:page, 0).to_i
    @products_per_page = Product.offset(@page * NUMBER_PRODUCTS_PER_PAGE).limit(NUMBER_PRODUCTS_PER_PAGE)
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

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
    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:title, :description, :user_id, :sold, :price, :category_id, :picture, :sort_id)
    end
end
