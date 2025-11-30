# frozen_string_literal: true

class AddDeviseToUsers < ActiveRecord::Migration[8.1]
  def self.up
    # DO NOT add any Devise columns because they already exist from earlier migration.
    # Only add missing indexes.

    unless index_exists?(:users, :reset_password_token)
      add_index :users, :reset_password_token, unique: true
    end
  end

  def self.down
    if index_exists?(:users, :reset_password_token)
      remove_index :users, :reset_password_token
    end
  end
end
