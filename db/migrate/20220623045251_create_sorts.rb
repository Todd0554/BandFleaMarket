class CreateSorts < ActiveRecord::Migration[6.1]
  def change
    create_table :sorts do |t|
      t.string :sort

      t.timestamps
    end
  end
end
