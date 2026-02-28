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
    return render_unauthorized unless token

    begin
      decoded = JsonWebTokenService.decode(token)
      @current_user = User.find(decoded[:user_id])
    rescue
      render_unauthorized
    end
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
