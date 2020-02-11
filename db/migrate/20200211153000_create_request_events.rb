class CreateRequestEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :request_events do |t|
      t.references :request, foreign_key: true
      t.string :state
      t.text :comment
      t.string :user_name

      t.timestamps
    end
  end
end
