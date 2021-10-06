class Api::V1::StarsController < ApplicationController
  before_action :set_blog, only: %i[create destroy]
  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: :not_found
  end

  def create
    star = @current_user.stars.new(blog_id: blog.id)
    if star.save
      render status: :created
    else
      render star.errors.full_messages
    end
  end

  def destroy
    star = @current_user.star.find_by(blog_id: blog.id)
    star.destroy!
    head :no_content
  end

  private

    def set_blog
      blog = Blog.find_by(url: params[:url])
    end
end
