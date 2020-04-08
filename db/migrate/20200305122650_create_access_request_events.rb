class CreateAccessRequestEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :access_request_events do |t|
      t.references :access_request, foreign_key: true
      t.string :state, default: "draft"
      t.string :comment
      t.string :user_name

      t.timestamps
    end
  end
end
