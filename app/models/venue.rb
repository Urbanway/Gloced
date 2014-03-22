class Venue < ActiveRecord::Base

  attr_accessible :name, :address, :slug, :city, :country, :state, :about, :logo, :zip, :venue_type, :longlat, :email, :website, :phone, :twitter, :fb
  belongs_to :user 
  has_many :event 
  has_attached_file :logo, :processors => [:watermark],
                :styles => { 
                            :medium => "310x>", 
                            :thumb => "100x100#", 
                            :minithumb => {
                              :geometry => "50x50#",
                              :watermark_path => Rails.root.join('public','images','watermark.png'),
                              :position => "south",
                              :format => 'png'
                              }
                            },       
         :url => "/venues/:attachment/:id/:style/:hash.:extension",
         :path => ":rails_root/public/venues/:attachment/:id/:style/:hash.:extension",
         :hash_secret => "longSecretString"
   def to_param
     slug
   end

end