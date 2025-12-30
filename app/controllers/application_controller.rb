class ApplicationController < ActionController::API
  before_action :authenticate_request

  attr_reader :current_user

  private

  def authorize_admin!
    return if current_user&.is_admin

    render json: { error: 'Forbidden' }, status: :forbidden
  end

  def authenticate_request
    token = extract_token
    decoded = JsonWebTokenService.decode(token)

    return render_unauthorized unless decoded

    @current_user = User.find_by(id: decoded[:user_id])
    render_unauthorized unless @current_user
  end

  def extract_token
    header = request.headers['Authorization']
    return nil unless header&.start_with?('Bearer ')

    header.split(' ').last
  end

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
