module PostsHelper

  def lastReply(post)
    post.replies.last
  end

  def hasReplies(post)
    !post.replies.empty?
  end
end