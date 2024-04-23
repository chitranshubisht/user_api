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
    users = User.all
    render json: users
  end

  private

  def permitted_params
    permitted_params.require(:user).permit(:name, :email)
  end
end
