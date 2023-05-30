class DropRolesAdminsAndRolesEmployees2 < ActiveRecord::Migration[6.1]
  def change
    drop_table :roles_admins
    drop_table :roles_employees
  end
end
