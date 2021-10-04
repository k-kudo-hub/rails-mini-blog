class Api::V1::MyBlogsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: :not_found
  end

  def index
    render json: blogs, methods: [:format_created_at, :cover_image_url, :user_picture, :user_name]
    blogs = Blog.personal(@current_user.id).undeleted.select_for_index
  end
end
