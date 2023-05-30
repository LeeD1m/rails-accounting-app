class DropRolesAdminsAndRolesEmployees < ActiveRecord::Migration[6.1]
  def change
    def up
      drop_table :roles_admins
      drop_table :roles_employees
    end
  
    def down
      raise ActiveRecord::IrreversibleMigration
    end
  end
end
