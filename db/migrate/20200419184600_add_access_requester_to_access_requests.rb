class AddAccessRequesterToAccessRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :access_requests, :access_requester_id, :integer, foreign_key: true
    add_index :access_requests, :access_requester_id
  end
end
