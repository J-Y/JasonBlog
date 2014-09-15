#encoding: utf-8
class Photo < ActiveRecord::Base

  validates_presence_of :title
  belongs_to :user
  # 封面图
  has_attached_file :image,
    :default_style => :normal,
    :styles => {
      :small => "100>",
      :normal => "680>",
    },
    :url => "#{APP_CONFIG['upload_url']}/:class/:attachment/:hashed_path/:id_:style.jpg",
    :path => "#{APP_CONFIG['upload_root']}/:class/:attachment/:hashed_path/:id_:style.jpg",
    :default_url => "photo/:style.jpg"

  validates_attachment_size :image, :greater_than => 0.0000001.megabytes, :message => "Image Empty"
  validates_attachment_size :image, :less_than => 10.megabytes, :message => "Image is too big"
  validates_attachment_content_type :image, :message => "Image type is error", :content_type => %w(image/png image/jpeg image/gif image/bmp)

  attr_accessible :image_file_name, :image_content_type, :image_file_size

  before_save :default_for_title
  def default_for_title
    self.title = "未命名" if self.title.blank?
  end
end
