#encoding: utf-8
class User < ActiveRecord::Base
   acts_as_authentic
  validates_presence_of :email, :name, :password
  validates_uniqueness_of :email, :name
  validates_format_of :email,  :with => /\A[\w+\-.']+@[a-z\d\-.]+\.[a-z]+\z/i
  has_many :topics
  has_many :replies

  has_attached_file :avatar,
  :default_style => :normal,
  :style => {
    :small => "16x16#",
    :normal => "48x48#",
    :large => "80>",
  },
  :url =>"#{APP_CONFIG['upload_url']}/:class/:attachment/:hashed_path/:id_:style.jpg",
  :path => "#{APP_CONFIG['upload_root']}/:class/:attachment/:hashed_path/:id_:style.jpg",
  :default_url => "avatar/:style.jpg"

  STATE = {
      :normal => 1,
      #屏蔽
      :blocked => 2
  }

#  Accessors
  #attr_accessible :email, :password, :password_confirmation, :name, :location, :bio, :website, :avatar_file_name, :verified, :state, :qq, :last_logined_at, :tagline

end
