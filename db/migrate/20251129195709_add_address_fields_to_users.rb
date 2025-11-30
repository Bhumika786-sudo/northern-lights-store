class AddAddressFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    # Add address if it doesn't already exist
    unless column_exists?(:users, :address)
      add_column :users, :address, :string
    end

    # Add city if it doesn't already exist
    unless column_exists?(:users, :city)
      add_column :users, :city, :string
    end

    # Add province reference if it doesn't already exist
    unless column_exists?(:users, :province_id)
      add_reference :users, :province, foreign_key: true
    end
  end
end
