class Api::V1::UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: :not_found
  end
  
  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      render json: user.name, status: :created
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    render json: @current_user
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
