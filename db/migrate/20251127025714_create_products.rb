class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :current_price
      t.integer :stock_quantity
      t.string :sku
      t.string :brand
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
