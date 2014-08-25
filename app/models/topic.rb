#encoding: utf-8
class Topic < ActiveRecord::Base
  validates_presence_of :user_id, :title, :body, :node_id
  belongs_to :node, :counter_cache => true
  belongs_to :user
  belongs_to :last_reply_user, :class_name => "User"

  has_many :replies, :dependent => :destroy#, :include => [:user]

  # scopes
  scope :last_actived, -> {joins(:user, :last_reply_user, :node).order ("replied_at desc, id desc")}

  scope :recents, -> {joins(:user, :last_reply_user, :node).order ("id desc")}

  before_save :set_replied_at

  def set_replied_at
      self.replied_at = Time.now
  end

  # 检查用户是否看过
  # result:
  #   0 读过
  #   1 未读
  #   2 最后是用户的回复
  def user_readed?(user_id)
    uids = Rails.cache.read("Topic:user_read:#{self.id}")
    if uids.blank?
      if self.last_reply_user_id == user_id || self.user_id == user_id
        return 2
      else
        return 1
      end
    end

    if uids.index(user_id)
      return 0
    else
      if self.last_reply_user_id == user_id || self.user_id == user_id
        return 2
      else
        return 1
      end
    end
  end

  # 记录用户读过
  def user_readed(user_id)
    uids = Rails.cache.read("Topic:user_read:#{self.id}")
    if uids.blank?
      uids = [user_id]
    else
      uids = uids.dup
    end

		uids << user_id
    Rails.cache.write("Topic:user_read:#{self.id}",uids)
  end

  # 清除用户读过的记录
  # 用户回复的时候清除状态
  def clear_user_readed
    Rails.cache.write("Topic:user_read:#{self.id}",nil)
  end

end
