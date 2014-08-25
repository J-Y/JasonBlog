#encoding: utf-8
class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update, :setting, :password]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:name, :password, :password_confirmation, :email, :location))
    if @user.save
      flash[:notice] = "会员注册成功!"
      redirect_back_or_default root_path
    else
      render :action => :new
    end
  end

  def show
    @user = @current_user
  end

  def edit
    @user = @current_user
  end

  def setting
    @user = @current_user
  end


  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
    flash[:notice] = "更改成功!"
      redirect_to setting_path
    else
      if params[:change_pwd]
        render :action => :password
      else
        render :action => :edit
      end

    end
  end

   def password
    @user = @current_user
  end
end
