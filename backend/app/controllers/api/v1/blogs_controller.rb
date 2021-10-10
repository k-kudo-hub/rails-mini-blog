class Api::V1::BlogsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: :not_found
  end

  def index
    blogs = Blog.tie.released.select_for_index.newest
    result = serialize_for_index(blogs, @current_user.id)
    render json: result
  end

  def create
    blog = Blog.new(blog_params)
    blog.set_url
    if blog.save
      render json: blog.url, status: :created
    else
      render json: blog.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    blog = Blog.find_by(url: params[:url])
    result = serialize_for_show(blog, @current_user.id)
    render json: result
  end

  def edit
    blog = @current_user.blogs.select_for_edit.find_by(url: params[:url])
    render json: blog, methods: %i[state_value cover_image_name]
  end

  def update
    blog = @current_user.blogs.find_by(url: params[:url])
    if blog.update(blog_params)
      render json: blog.url, status: :created
    else
      rebder json: blog.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    blog = @current_user.blogs.find_by(url: params[:url])
    blog.logical_deletion
    head :no_content
  end

  private

    def blog_params
      params.require(:blog).permit(:subject, :body, :cover_image, :state_number).merge(user: @current_user)
    end

    # FIXME!: ここにserializeを置いておきたくない
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

    # FIXME!: ここにserializeを置いておきたくない
    def serialize_for_show(blog, id)
      stars = blog.stars.pluck(:user_id)
      result = {
        id: blog.id,
        subject: blog.subject,
        body: blog.body,
        url: blog.url,
        format_updated_at: blog.format_updated_at,
        cover_image_url: blog.cover_image_url,
        user_id: blog.user.id,
        user_name: blog.user.name,
        user_picture: blog.user_picture,
        user_introduce: blog.user.introduce,
        is_liked: stars.include?(id),
        liked_count: stars.count
      }
      result
    end
end
