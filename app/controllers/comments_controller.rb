class CommentsController < ApplicationController

  def new
  @post = Post.find(params[:post_id])
  @comments = Comments.new
  end

  def create
  @post = Post.find(params[:post_id])
  @post.comments.create(comments_params)
  redirect_to '/posts'
  end

private

  def comments_params
    params.require(:comments).permit(:thoughts)
  end

end
