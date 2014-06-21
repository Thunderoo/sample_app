class RepliesController < ApplicationController
  before_action :signed_in_user

  def show
  end

  def create
    post = Post.all.find(params[:reply][:post_id])
    @reply = post.replies.build(reply_params)
    if @reply.save
      flash[:success] = "Reply added!"
      redirect_to post_path(post)
    else
      @post = post
      @forum = Forum.find(@post.forum_id)
      @replies = @post.replies.paginate(page: params[:page])
      @op_user = User.find(@post.user_id)
      render 'posts/show'
    end
  end

  def destroy
    @forum = Forum.find_by(id: params[:forum_id])
    @post.destroy
    redirect_to forum_path(@forum)
  end

  private

  def reply_params
    params.require(:reply).permit(:content, :user_id)
  end

  def correct_forum
    @post = current_forum.posts.find_by(id: params[:id])
    redirect_to forums_path(current_forum) if @post.nil?
  end
end