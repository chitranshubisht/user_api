class AuthenticationController < ApplicationController
  include JwtToken
  skip_before_action :authenticate_user

  def login
    if params[:email].blank? || params[:password].blank?
      render json: { error: 'Missing email or password' }, status: :unprocessable_entity
      return
    end

    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = jwt_encode({ user_id: @user.id })
      time = Time.now + 24.hours.to_i
      render json: { token:, exp: time.strftime('%m-%d-%Y %H:%M'), name: @user.name }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end
end
