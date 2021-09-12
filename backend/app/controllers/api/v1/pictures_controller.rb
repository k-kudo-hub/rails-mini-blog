class Api::V1::PicturesController < ApplicationController
  skip_before_action :require_login, only: [:create]
  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: :not_found
  end

  def upload_picture
    user = User.find(@current_user.id)
    if user.valid?(:picture_validation)
      user.update(upload_picture_params)
      render json: user.picture_url, status: :created
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def upload_cover
    user = User.find(@current_user.id)
    if user.valid?(:cover_validation)
      user.update(upload_cover_params)
      render json: user.cover_url, status: :created
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def upload_picture_params
    params.require(:user).permit(:picture)
  end

  def upload_cover_params
    params.require(:user).permit(:cover)
  end
end
