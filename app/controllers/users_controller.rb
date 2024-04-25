class UsersController < ApplicationController
  def create
    user = User.new(permitted_params)
    if user.save
      render json: user, status: ok
    else
      render json: user.errors, status: unprocessable_entity
    end
  end

  def index
    users_posts = User.includes(:posts)
    render json: users_posts.to_json(include: :posts)
  end

  private

  def permitted_params
    permitted_params.require(:user).permit(:name, :email)
  end
end
