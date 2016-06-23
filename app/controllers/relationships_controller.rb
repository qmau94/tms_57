class RelationshipsController < ApplicationController
  before_action :logged_in_user, only: [:index, :create, :destroy]
  before_action :find_user, only: :index
  def index
    @title = t "relationship.#{params[:action_type]}"
    @users = @user.send(params[:action_type]).page params[:page]
  end

  def create
    @user = User.find_by id: params[:followed_id]
    current_user.follow @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow @user 
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end
  
  private
  def find_user
    @user = User.find_by id: params[:user_id]
    unless @user.present?
      flash[:danger] = t "flash.empty"
      redirect_to root_url
    end
  end
end
