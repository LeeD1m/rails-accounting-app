class AddDefaultRoleToUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :role, 'default_role'
  end
end
