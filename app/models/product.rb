class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :sort
  has_rich_text :description
  has_one_attached :picture
end
