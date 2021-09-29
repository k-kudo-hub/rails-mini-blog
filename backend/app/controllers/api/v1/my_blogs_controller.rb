class Api::V1::MyBlogsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: :not_found
  end

  def index
    blogs = Blog.personal(@current_user.id).select_for_index
    render json: blogs, methods: [:format_created_at, :cover_image_url, :user_picture, :user_name]
  end
end
