class Api::V1::MyBlogsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: :not_found
  end

  def index
    blogs = Blog.personal(@current_user.id).undeleted.select_for_index
    result = serialize_for_index(blogs, @current_user.id)
    render json: result
  end

  def index_my_stars
    blogs = Blog.liked(@current_user.star_blog_ids)
    result = serialize_for_index(blogs, @current_user.id)
    render json: result
  end

  def index_higher_rating
    blogs = Blog.liked(Star.pluck(:blog_id)).rank(10)
    result = serialize_for_index(blogs, @current_user.id)
    render json: result
  end

  private

  def serialize_for_index(blogs, id)
    result = blogs.map do |blog|
               stars = blog.stars.pluck(:user_id)
               item = {
                 id: blog.id,
                 subject: blog.subject,
                 url: blog.url,
                 format_created_at: blog.format_created_at,
                 cover_image_url: blog.cover_image_url,
                 user_id: blog.user.id,
                 user_name: blog.user.name,
                 user_picture: blog.user_picture,
                 is_liked: stars.include?(id),
                 liked_count: stars.count
               }
             end
    result
  end
end
