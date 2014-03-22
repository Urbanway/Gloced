class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.integer :venue_id
      t.string :name
      t.string :slug
      t.text :description
      t.text :tags
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
