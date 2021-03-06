class Api::V1::UsersController < ApplicationController
  skip_before_action :require_login, only: [:create]
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
    render json: @current_user, methods: %i[picture_url cover_url]
  end

  def update
    user = User.find(@current_user.id)
    user.assign_profile_attributes(user_update_params[:name], user_update_params[:introduce], user_update_params[:link])
    if user.valid?(:update_profile_validation) && user.update(user_update_params)
      response = { name: user.name, introduce: user.introduce, link: user.link }
      render json: response, status: :created
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy; end

  private

    def user_create_params
      params.require(:user).permit(:name, :email, :password)
    end

    def user_update_params
      params.require(:user).permit(:name, :introduce, :link)
    end
end
