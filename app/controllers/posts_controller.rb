class PostsController < ApplicationController
  
  def create
    user = User.find_by(id: permitted_params[:user_id].to_i)
    post = user.posts.new(permitted_params.except(:user_id))
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
    params.require(:post).permit(:user_id, :title, :description)
  end
end
