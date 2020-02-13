class CreateEndUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :end_users do |t|
    	t.string :first_name
      t.string :last_name
      t.string :email
      t.references :role

      t.timestamps
    end
  end
end
