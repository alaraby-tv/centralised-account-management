class CreateJoinTableAccessAcountsPermissions < ActiveRecord::Migration[5.2]
  def change
    create_join_table :access_accounts, :permissions do |t|
      # t.index [:access_account_id, :permission_id]
      # t.index [:permission_id, :access_account_id]
    end
  end
end
