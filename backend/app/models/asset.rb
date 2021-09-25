class Asset < ApplicationRecord
  belongs_to :user
  mount_uploader :file, AssetUploader

  # TODO: 環境変数で置き換える
  BASE_URL = 'http://localhost:3000'

  def file_url
    file.present? ? "#{BASE_URL}#{file.url}" : nil
  end
end
