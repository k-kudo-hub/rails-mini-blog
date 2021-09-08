class Api::V1::SessionsController < ApplicationController
  skip_before_action :require_login
  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: :not_found
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      response = { id: user.id, name: user.name }
      render json: response
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    head :no_content
  end

  private

    def session_params
      params.require(:session).permit(:email, :password)
    end
end
