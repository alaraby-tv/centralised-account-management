class CreateJoinTableAccessRequestsPermissions < ActiveRecord::Migration[5.2]
  def change
    create_join_table :access_requests, :permissions do |t|
      # t.index [:access_request_id, :permission_id]
      # t.index [:permission_id, :access_request_id]

      t.timestamps
    end  
  end
end
