json.extract! product, :id, :title, :description, :user_id, :sold, :price, :category_id, :created_at, :updated_at
json.url product_url(product, format: :json)
json.description product.description.to_s
