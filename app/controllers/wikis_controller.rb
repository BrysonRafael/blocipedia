class WikisController < ApplicationController
  def index
    user_id = -999
    if current_user != nil
      user_id = current_user.id
    end

    @wikis = policy_scope(Wiki)
    @wikis = Wiki.where("private IS NULL or private = ? or user_id = ?", false, user_id)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
    @wiki.private = params[:wiki][:private]
  end

  def create
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    @wiki.user_id = current_user.id



    if @wiki.save
      redirect_to @wiki
    else
      flash[:notice] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    require 'redcarpet'
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    @wiki.user_id = current_user.id
    @wiki.collaborators = params[:wiki][:collaborators]

    

    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
       flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
       redirect_to wikis_path
     else
       flash.now[:alert] = "There was an error deleting the wiki."
       render :show
    end
  end
end
