class Blog < ApplicationRecord
  require 'securerandom'
  extend Enumerize
  belongs_to :user
  has_many :stars

  mount_uploader :cover_image,   CoverUploader
  enumerize :state_number, in: { draft: 0, limited: 1, released: 2, deleted: 3 }

  # TODO: 環境変数で置き換える
  BASE_URL = 'http://localhost:3000'
  SUBJECT_MAXIMUM_LENGTH = 50

  validates :subject,       presence: true,
                            length: { maximum: SUBJECT_MAXIMUM_LENGTH }
  validates :state_number,  presence: true,
                            numericality: { in: 0..3 }
  validates :url,           presence: true,
                            uniqueness:   { message: 'の生成で問題が発生しました。お手数ですが再度「保存する」を押してください。' }, on: :create

  scope :personal, ->(id) {
    includes(:user, :stars).where(user_id: id)
  }

  scope :released, -> {
    includes(:user, :stars).where(state_number: 2)
  }

  scope :select_for_index, -> {
    select(:id, :user_id, :subject, :cover_image, :url, :created_at).order(created_at: :desc)
  }

  scope :select_for_edit, -> {
    select(:id, :subject, :body, :cover_image, :state_number, :url)
  }

  scope :undeleted, -> {
    where(state_number: 0..2)
  }

  delegate :id, to: :user, prefix: true

  delegate :name, to: :user, prefix: true

  delegate :introduce, to: :user, prefix: true

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

  def logical_deletion
    update(state_number: 3)
  end

  def random_url
    SecureRandom.hex(20)
  end

  def set_url
    self.url = random_url
  end

  def state_value
    state_number_value
  end
  
  def user_picture
    user.picture.present? ? "#{BASE_URL}#{user.picture.url}" : nil
  end
end
