class Event < ActiveRecord::Base
  attr_accessible :user_id, :venue_id, :name, :description, :tag_list, :start_time, :end_time, :poster
  acts_as_taggable_on
  acts_as_taggable_on :tags
  belongs_to :user 
  belongs_to :venue 
  self.per_page = 3
  has_attached_file :poster, :processors => [:watermark],
                 :styles => { 
                             :medium => "310", 
                             :thumb => "150", 
                             :minithumb => {
                               :geometry => "50",
                               :format => 'png'
                               }
                             },       
          :url => "/events/:attachment/:id/:style/:hash.:extension",
          :path => ":rails_root/public/events/:attachment/:id/:style/:hash.:extension",
          :hash_secret => "longSecretString",
          :default_url => "/events/:attachment/:style/missing.png"
          
  validates_attachment_size :poster, :less_than => 1.megabytes
  
  before_save :create_slug
  
  def to_param
    slug
  end
  
  def poster_url
      poster.url(:minithumb)
  end

  def create_slug
    self.slug =  [self.id, self.name.parameterize].join("-")
  end
  
end
