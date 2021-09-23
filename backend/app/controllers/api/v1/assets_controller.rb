class Api::V1::AssetsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: :not_found
  end

  def create
    asset = Asset.new(asset_params)
    if asset.save
      render json: asset, status: :created
    else
      render json: asset.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    asset = @current_user.assets.find(params[:id])
    asset.destroy!
    head :no_content
  end

  private

  def asset_params
    params.require(:asset).permit(:file, :alt).merge(user: @current_user)
  end
end
