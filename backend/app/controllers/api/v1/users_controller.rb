class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      render json: user.name, status: :created
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
