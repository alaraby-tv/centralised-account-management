class AddRoleReferenceToUsers < ActiveRecord::Migration[5.2]
  def up
    add_reference :users, :role, foreign_key: true
  end

  def down
    remove_reference :users, :role
end
