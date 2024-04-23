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
    posts = Post.all
    render json: posts
  end

  private

  def permitted_params
    params.require(:post).permit(:title, :description)
  end
end
