class Api::V1::BlogsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: :not_found
  end

  def create
    blog = Blog.new(blog_params)
    blog.set_url
    if blog.save
      render json: blog, status: :created, methods: [:state_value]
    else
      render json: blog.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

    def blog_params
      params.require(:blog).permit(:subject, :body, :cover_image, :state_number).merge(user: @current_user)
    end
end
