#encoding: utf-8
class Cpanel::HomeController < Cpanel::ApplicationController
  def index
    @recent_topics = Topic.recents.limit(5)
  end
end
