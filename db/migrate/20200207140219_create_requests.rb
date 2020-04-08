class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.references :end_user, foreign_key: true
      t.integer :requester_id, foreign_key: true
      t.text :note
      t.string :status, default: "draft"

      t.timestamps
    end

    add_index :requests, :requester_id
  end
end
