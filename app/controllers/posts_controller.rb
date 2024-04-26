class PostsController < ApplicationController
  def create
    post = Post.new(permitted_params)
    if post.save
      render json: post, status: :ok
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end

  def index
    posts = Post.includes(:user)
    render json: posts.to_json(include: :user)
  end

  private

  def permitted_params
    params.require(:post).permit(:title, :description)
  end
end
