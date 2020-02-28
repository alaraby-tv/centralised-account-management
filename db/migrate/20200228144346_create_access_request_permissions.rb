class CreateAccessRequestPermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :access_request_permissions do |t|
      t.references :access_request, foreign_key: true
      t.references :permission, foreign_key: true

      t.timestamps
    end
  end
end
