class AddColumnsToProvinces < ActiveRecord::Migration[7.0]
  def change
    add_column :provinces, :code,     :string unless column_exists?(:provinces, :code)
    add_column :provinces, :gst_rate, :decimal, precision: 5, scale: 4 unless column_exists?(:provinces, :gst_rate)
    add_column :provinces, :pst_rate, :decimal, precision: 5, scale: 4 unless column_exists?(:provinces, :pst_rate)
    add_column :provinces, :hst_rate, :decimal, precision: 5, scale: 4 unless column_exists?(:provinces, :hst_rate)
  end
end
