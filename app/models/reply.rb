#encoding: utf-8
class Reply < ActiveRecord::Base
  validate_presence_of :body
  belongs_to :topic, :counter_cache => true
  belongs_to :user

  after_create :update_parent_last_replied

  def update_parent_last_replied
    self.topic.replied_at = Time.now
    self.topic.last_reply_user_id = self.user_id
    seld.topic.save

    #清除用户读过的记录
    self.topic.clear_user_readed
  end
end
