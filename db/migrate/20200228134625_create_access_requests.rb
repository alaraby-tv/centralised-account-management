class CreateAccessRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :access_requests do |t|
      t.references :access_account, foreign_key: true
      t.references :request, foreign_key: true

      t.timestamps
    end
  end
end
