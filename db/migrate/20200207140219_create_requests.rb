class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.references :end_user, foreign_key: true
      t.integer :requester_id, foreign_key: true
      t.references :access_account, foreign_key: true
      t.references :permission, foreign_key: true
      t.string :state
      t.string :approver_name
      t.text :note

      t.timestamps
    end

    add_index :requests, :requester_id
  end
end
