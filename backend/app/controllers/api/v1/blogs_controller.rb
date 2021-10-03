class Api::V1::BlogsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: :not_found
  end

  def index
    blogs = Blog.released.select_for_index
    render json: blogs, methods: [:format_created_at, :cover_image_url, :user_picture, :user_name]
  end

  def create
    blog = Blog.new(blog_params)
    blog.set_url
    if blog.save
      render json: blog, status: :created, methods: [:format_updated_at, :cover_image_url, :user_picture, :user_name]
    else
      render json: blog.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    blog = Blog.find_by(url: params[:url])
    render json: blog, methods: [:format_updated_at, :cover_image_url, :user_picture, :user_name, :user_introduce, :user_id]
  end

  def edit
    blog = Blog.select_for_edit.find_by(url: params[:url])
    render json: blog, methods: [:state_value, :cover_image_name]
  end

  def update
    blog = Blog.find_by(url: params[:url])
    if blog.update(blog_params)
      render json: blog.url, status: :created
    else
      rebder json: blog.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

    def blog_params
      params.require(:blog).permit(:subject, :body, :cover_image, :state_number).merge(user: @current_user)
    end
end
