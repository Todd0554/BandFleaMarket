class AddSortToProducts < ActiveRecord::Migration[6.1]
  def change
    add_reference :products, :sort, null: false, foreign_key: true
  end
end
