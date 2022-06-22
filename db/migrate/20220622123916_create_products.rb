class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :title
      t.references :user, null: false, foreign_key: true
      t.boolean :sold, default: false
      t.integer :price
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
