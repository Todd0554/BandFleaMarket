class AddCategoryToSorts < ActiveRecord::Migration[6.1]
  def change
    add_reference :sorts, :category, null: false, foreign_key: true
  end
end
