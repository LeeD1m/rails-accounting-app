class OptionalActor < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :actor_id, true

  end
end
