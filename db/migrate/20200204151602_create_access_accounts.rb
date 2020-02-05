class CreateAccessAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :access_accounts do |t|
      t.string :name
      t.belongs_to :approver

      t.timestamps
    end
  end
end
