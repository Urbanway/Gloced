class Upload < ActiveRecord::Base
  attr_accessible :user_id, :photo 
  belongs_to :user 
  has_attached_file :photo, :styles => { :medium => "310x310>", :thumb => "100x100>" }
  
end