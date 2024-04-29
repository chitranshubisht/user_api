class ApplicationController < ActionController::Base
  include JwtToken
  protect_from_forgery with: :null_session
  before_action :authenticate_user, unless: :active_admin_request?

  def authenticate_user
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = jwt_decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  private

  def active_admin_request?
    request.path.include?('/admin')
  end
end
