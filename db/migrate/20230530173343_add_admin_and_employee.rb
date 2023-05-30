class AddAdminAndEmployee < ActiveRecord::Migration[6.1]
  def change
    create_table :roles_employees do |t|
      t.string :name
      t.string :surname

      t.timestamps
    end
      create_table :roles_admins do |t|
        t.string :name
        t.string :surname
  
        t.timestamps
      end
  end
end
