class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string  :customer_name
      t.string  :address
      t.string  :city
      t.string  :province
      t.decimal :subtotal, precision: 10, scale: 2
      t.decimal :gst,      precision: 10, scale: 2
      t.decimal :pst,      precision: 10, scale: 2
      t.decimal :hst,      precision: 10, scale: 2
      t.decimal :total,    precision: 10, scale: 2
      t.string  :status

      t.timestamps
    end
  end
end
