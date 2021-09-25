class ApplicationController < ActionController::API
  include ActionController::Cookies
  before_action :check_xhr_header
  before_action :require_login

  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: :not_found
  end

  private

    def require_login
      @current_user = User.find_and_select_by_id(session[:user_id])
      return if @current_user

      render json: { error: 'unauthorized' }, status: :unauthorized
    end

    def check_xhr_header
      return if request.xhr?

      render json: { error: 'forbidden: 不正なアクセスが確認されました。' }, status: :forbidden
    end
end
