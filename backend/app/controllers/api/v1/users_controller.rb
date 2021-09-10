class Api::V1::UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: :not_found
  end
  
  def create
    user = User.new(user_create_params)
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

  def update
    user = User.find(@current_user.id)
    if user.update(user_update_params)
      response = { name: user.name, introduce: user.introduce, link: user.link }
      render json: response, status: :created
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def user_create_params
    params.require(:user).permit(:name, :email, :password)
  end
  
  def user_update_params
    params.require(:user).permit(:name, :introduce, :link)
  end
end
