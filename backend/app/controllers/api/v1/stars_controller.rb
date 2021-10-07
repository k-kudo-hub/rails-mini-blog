class Api::V1::StarsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: :not_found
  end

  def create
    blog = Blog.find_by(url: params[:url])
    star = @current_user.stars.new(blog_id: blog.id)
    if star.save
      render status: :created
    else
      render json: star.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    blog = Blog.find_by(url: params[:url])
    star = @current_user.star.find_by(blog_id: blog.id)
    star.destroy!
    head :no_content
  end
end
