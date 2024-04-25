class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]
  before_action :find_user, only: %i[show]

  def create
    user = User.new(permitted_params)
    if user.save
      render json: user, status: :ok
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def index
    users = User.all
    render json: users
  end

  def show
    render json: @user, status: :ok
  end

  def update
    return if @user.update(permitted_params)

    render json: { errors: @user.errors.full_messages }, status: :service_unavailable
  end

  private

  def permitted_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find_by(params[:id])
  end
end
