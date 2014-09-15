# encoding: utf-8  
class NotesController < ApplicationController
  before_filter :require_user
  # GET /notes
  # GET /notes.xml
  def index
    @notes = @current_user.notes.paginate :page => params[:page], :per_page => 20
  end

  # GET /notes/1
  # GET /notes/1.xml
  def show
    @note = Note.find(params[:id])
  end

  # GET /notes/new
  # GET /notes/new.xml
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
    @note = Note.find(params[:id])
  end

  # POST /notes
  # POST /notes.xml
  def create
    @note = Note.new(params[:note])
    @note.user_id = @current_user.id

    if @note.save
      redirect_to(@note, :notice => '创建成功。')
    else
      render :action => "new"
    end
  end

  # PUT /notes/1
  # PUT /notes/1.xml
  def update
    @note = Note.find(params[:id])
    if @note.user_id != @current_user.id
      render_404
    end

    if @note.update_attributes(params[:note])
      redirect_to(@note, :notice => '修改成功。')
    else
      render :action => "edit"
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.xml
  def destroy
    @note = Note.find(params[:id])
    if @note.user_id != @current_user.id
      render_404
    end
    @note.destroy

    redirect_to(notes_url)
  end
end
