class CreateAccessAccountPermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :access_account_permissions do |t|
      t.references :access_account, foreign_key: true
      t.references :permission, foreign_key: true

      t.timestamps
    end
  end
end
