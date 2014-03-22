class AddLogoColumnsToVenue < ActiveRecord::Migration
  def self.up
    change_table :venues do |t|
      t.has_attached_file :logo
    end
  end

  def self.down
    drop_attached_file :venues, :logo
  end
end