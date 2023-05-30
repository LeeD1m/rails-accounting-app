class CreateAdmins < ActiveRecord::Migration[6.1]
  def change
    create_table :admins do |t|
      t.string :name
      t.timestamps
    end
    create_table :employees do |t|
      t.string :name
      t.timestamps
    end
  end
end
