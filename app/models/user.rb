class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :recoverable, :rememberable, :registerable, :trackable, :validatable, :authentication_keys => [:login]
   
  has_attached_file :avatar, :styles => { :large => "600x600>", :medium => "310x310>", :thumb => "100x100#", :minithumb => "50x50#" },       
           :url => "/:attachment/:id/:style/:hash.:extension",
           :path => ":rails_root/public/:attachment/:id/:style/:hash.:extension",
           :hash_secret => "longSecretString",
           :default_url => '/avatars/:style/missing.png'
           
   validates_attachment_size :avatar, :less_than => 5.megabytes
   validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png']       
  # Setup accessible (or protected) attributes for your model
  attr_accessible :firstName, :lastName, :about, :city, :state, :country, :places, :avatar,:site_u_r_l, :login, :email, :password, :password_confirmation, :remember_me ,:username, :language, :timezone
 
  attr_accessor :login
  
 
  has_many :relationships, :dependent => :destroy,
                           :foreign_key => "follower_id"
  has_many :reverse_relationships, :dependent => :destroy,
                                   :foreign_key => "followed_id",
                                   :class_name => "Relationship"

  has_many :following, :through => :relationships, :source => :followed
  has_many :followers, :through => :reverse_relationships, :source => :follower
  has_many :venues
  has_many :events
  
  def confirm!
    welcome_message
    super
  end
  
  def following?(followed)
    relationships.find_by_followed_id(followed)
  end

  def followed
    relationships.find_by_following_id(current_user.id)
  end

  def follow!(followed)
    relationships.create!(:followed_id => followed.id)
  end

  def unfollow!(followed)
    relationships.find_by_followed_id(followed).destroy
  end
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.strip.downcase }]).first
  end
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end 
  def to_param
    username
  end
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(avatar.path(style))
  end
  
  private
  
  def welcome_message
     UserMailer.welcome_message(self).deliver
  end
  
  def reprocess_avatar
    avatar.reprocess!
  end
  
end
