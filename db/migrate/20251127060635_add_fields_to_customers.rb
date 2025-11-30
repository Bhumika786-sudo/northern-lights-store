class AddFieldsToCustomers < ActiveRecord::Migration[8.1]
  def change
    add_column :customers, :address, :string
    add_column :customers, :city, :string
    add_reference :customers, :province, null: false, foreign_key: true
  end
end
