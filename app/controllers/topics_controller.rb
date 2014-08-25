#encoding: utf-8
class TopicsController < ApplicationController
  before_filter :require_user, :only => [:new,:edit,:create,:update,:destroy,:reply]
  before_filter :init_list_sidebar, :only => [:index,:recent,:cate,:search]



  # GET /topics
  # GET /topics.xml
  def index
    @topics = Topic.last_actived.limit(10)
    set_seo_meta("社区论坛","#{APP_CONFIG['app_name']}社区,#{APP_CONFIG['app_name']}论坛,#{APP_CONFIG['app_name']}小区论坛,#{APP_CONFIG['app_name']}业主论坛")
  end

  def node
    @node = Node.find(params[:id])
    if @current_user
      Node.set_user_last_visited(@current_user.id, @node.id)
    end
    @topics = @node.topics.last_actived.paginate(:page => params[:page],:per_page => 50)
    set_seo_meta("#{@node.name} &raquo; 社区论坛","#{APP_CONFIG['app_name']}社区#{@node.name}",@node.summary)
    render :action => "index"
  end

  def recent
    @topics = Topic.recents.limit(50)
    set_seo_meta("最近活跃的50个帖子 &raquo; 社区论坛")
    render :action => "index"
  end

  def search
    @topics = Topic.search params[:s], :page => params[:page], :per_page => 50, :include => [:user, :last_reply_user]
    set_seo_meta("搜索#{params[:s]} &raquot; 社区论坛")
    render :action => "index"

  end

  # GET /topics/1
  # GET /topics/1.xml
  def show
    @topic = Topic.find(params[:id])
    if @current_user
      Node.set_user_last_visited(@current_user.id, @topic.node_id)
      @topic.user_readed(@current_user.id)
    end
    @node = @topic.node
    @replies = @topic.replies.all
    set_seo_meta("#{@topic.title} &raquot; 社区论坛")
  end

  # GET /topics/new
  # GET /topics/new.xml
  def new
    @topic = Topic.new
    @topic.node_id = params[:node]
    @node = Node.find(params[:node])
    if @node.blank?
      render_404
    end
  end

  def reply
    @topic = Topic.find(params[:id])
    @reply = @topic.replies.build(params.require(:reply).permit(:body, :state, :source))
    @reply.topic_id = params[:id]
    @reply.user_id = @current_user.id
    if @reply.save
      flash[:notice] = "回复成功。"
    else
      flash[:notice] = @reply.errors.full_messages.join("<br />")
    end
    redirect_to topic_path(params[:id])
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
    if @topic.user_id != @current_user.id
      return render_404
    end

  end

  # POST /topics
  # POST /topics.xml
  def create
    @topic = Topic.new(params.require(:topic).permit(:title, :node_id, :body))
    @topic.user_id = @current_user.id

    if @topic.save
      redirect_to(topics_path, :notice => '帖子创建成功.')
    else
      render :action => "new"
    end
  end

  # PUT /topics/1
  # PUT /topics/1.xml
  def update
    @topic = Topic.find(params[:id])
    if @topic.user_id != @current_user.id
      return render_404
    end

    if @topic.update_attributes(params[:topic])
      redirect_to(topics_path, :notice => '帖子修改成功.')
    else
      render :action => "edit"
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.xml
  def destroy
    @topic = Topic.find(params[:id])
    if @topic.user_id != @current_user.id
      return render_404
    end
    @topic.destroy
  redirect_to(topics_path, :notice => '帖子删除成功.')
  end

  private
  def init_list_sidebar
   if !fragment_exist? "topic/init_list_sidebar/hot_nodes.#{params[:format]}"
      @hot_nodes = Node.hots.limit(10)
    end
    if @current_user
      @user_last_nodes = Node.find_last_visited_by_user(@current_user.id)
    end
  end

end
