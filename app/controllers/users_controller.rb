class UsersController < ApplicationController
  before_action :find_user

  def create
    user = User.new(permitted_params)
    if user.save
      render json: user, status: :ok
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def index
    users = User.includes(:posts)
    render json: users
  end

  def show
    render json: @user, status: :ok
  end

  def update
    if @user.update(permitted_params)
      render json: @user, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :service_unavailable
    end
  end

  private

  def permitted_params
    params.require(:user).permit(:name, :email, :password)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
