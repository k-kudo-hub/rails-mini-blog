class Api::V1::AssetsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: :not_found
  end

  def index
    assets = @current_user.assets_selected
    render json: assets, methods: [:file_url]
  end

  def create
    asset = Asset.new(asset_params)
    if asset.save
      render json: asset, status: :created, methods: [:file_url]
    else
      render json: asset.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    asset = @current_user.assets.find(params[:id])
    if asset.destroy!
      render json: params[:id]
    end
  end

  private

  def asset_params
    params.require(:asset).permit(:file, :alt).merge(user: @current_user)
  end
end
