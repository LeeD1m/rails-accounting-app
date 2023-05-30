class AddRoleUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :password_digest, :string
    add_column :users, :role, :string
  end
end
