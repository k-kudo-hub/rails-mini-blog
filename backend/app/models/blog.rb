class Blog < ApplicationRecord
  require 'securerandom'
  extend Enumerize
  belongs_to :user

  mount_uploader :cover_image,   CoverUploader
  enumerize :state_number, in: { draft: 0, limited: 1, release: 2 }

  # TODO: 環境変数で置き換える
  BASE_URL = 'http://localhost:3000'
  SUBJECT_MAXIMUM_LENGTH = 50

  validates :subject,       presence: true,
                            length: { maximum: SUBJECT_MAXIMUM_LENGTH }
  validates :state_number,  numericality: { in: 0..2 }
  validates :url,           uniqueness:   { message: 'URL生成で問題が発生しました。お手数ですが再度「保存する」を押してください。' }, on: :create

  scope :released, -> {
    where(state_number: 2)
  }

  scope :personal, ->(id) {
    where(user_id: id)
  }

  scope :select_for_index, -> {
    select(:id, :user_id, :subject, :cover_image, :url, :created_at).order(created_at: :desc)
  }

  scope :select_for_edit, -> {
    select(:id, :subject, :body, :cover_image, :state_number, :url)
  }

  def set_url
    self.url = random_url
  end

  def random_url
    SecureRandom.hex(20)
  end

  def state_value
    state_number_value
  end

  def cover_image_url
    cover_image.present? ? "#{BASE_URL}#{cover_image.url}" : nil
  end

  def cover_image_name
    cover_image.present? ? cover_image.identifier : nil
  end

  def format_created_at
    created_at.to_s(:short)
  end

  def format_updated_at
    updated_at.to_s(:short)
  end

  def user_id
    user.id
  end
  
  def user_name
    user.name
  end
  
  def user_introduce
    user.introduce
  end
  
  def user_picture
    user.picture.present? ? "#{BASE_URL}#{user.picture.url}" : nil
  end
end
