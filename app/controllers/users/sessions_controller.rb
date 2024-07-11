class Users::SessionsController < Devise::SessionsController
  respond_to :json
  private
  def respond_with(current_user, _opts = {})
    render json: current_user, status: :ok
  end
  def respond_to_on_destroy
    if request.headers['Authorization'].present?
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, Rails.application.credentials.jwt_secret_key!).first
      current_user = User.find(jwt_payload['sub'])
    end

    if current_user
      render json: {
        status: 200,
        message: 'logged out successfully'
      }, status: :ok
    else
      render json: {
        status: 401,
        message: 'couldnt find an active user'
      }, status: :unauthorized
    end
  end
end
