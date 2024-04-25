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
    @users = User.all
    users = { users: ActiveModelSerializers::SerializableResource.new(@users.all, each_serializer: UserSerializer) }
    render json: { data: users }, status: :ok
  end

  private

  def permitted_params
    permitted_params.require(:user).permit(:name, :email)
  end
end
