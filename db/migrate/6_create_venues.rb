class CreateVenues < ActiveRecord::Migration
  def self.up
    create_table :venues do |t|
      t.integer :user_id
      t.string :name
      t.string :slug
      t.string :address
      t.string :city
      t.string :zip
      t.string :country
      t.string :about
      t.string :venue_type
      t.string :longlat
      t.string :email
      t.string :website
      t.string :phone
      t.string :twitter
      t.string :fb
      t.timestamps
    end
  end

  def self.down
    drop_table :venues
  end
end
