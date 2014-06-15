class ForumsController < ApplicationController
  before_action :signed_in_user

  def index
    @forums = Forum.paginate(page: params[:page])
  end

  def show
    @forum = Forum.find(params[:id])
    @threads = @user.posts.paginate(page: params[:page])
  end

  def destroy
    @forum = Forum.find(params[:id])
    @forum.destroy
    flash[:success] = "Forum deleted."
    redirect_to forums_url
  end

end