class PostsController < ApplicationController
  before_action :signed_in_user

  def show
    @post = Post.find(params[:id])
    @forum = Forum.find(@post.forum_id)
    @replies = @post.replies.paginate(page: params[:page])
    @op_user = User.find(@post.user_id)
    @reply = @post.replies.build
  end

  def create
    forum = Forum.all.find_by(params[:post][:forum_id])
    @post = forum.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to forum_path(forum)
    else
      @forum = forum
      @posts = @forum.posts.paginate(page: params[:page])
      render 'forums/show'
    end
  end

  def destroy
    @forum = Forum.find_by(id: params[:forum_id])
    @post.destroy
    redirect_to forum_path(@forum)
  end

  private

  def post_params
    params.require(:post).permit(:content, :title, :user_id)
  end

  def correct_forum
    @post = current_forum.posts.find_by(id: params[:id])
    redirect_to forums_path(current_forum) if @post.nil?
  end


end