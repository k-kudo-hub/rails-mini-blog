class User < ApplicationRecord
  has_secure_password
  mount_uploader :picture, PictureUploader
  mount_uploader :cover,   CoverUploader

  has_many :blogs
  has_many :assets
  has_many :stars

  VALID_EMAIL_REGEX        = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PASSWORD_REGAX     = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,100}+\z/i
  VALID_URL_REGAX          = /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/
  NAME_MAXIMUM_LENGTH      = 20
  INTRODUCE_MAXIMUM_LENGTH = 250
  # TODO: 環境変数で置き換える
  BASE_URL                 = 'http://localhost:3000'

  validates :name,      presence: true, on: :create,
                        length: { maximum: NAME_MAXIMUM_LENGTH }
  validates :email,     presence: true, on: :create,
                        format: { with: VALID_EMAIL_REGEX }, on: :create,
                        uniqueness: true, on: :create
  validates :password,  presence: true, on: :create,
                        format: { with: VALID_PASSWORD_REGAX, message: 'は8文字以上の半角英数字混合で登録できます。' }, on: :create

  with_options on: :update_profile_validation do
    validates :name,      presence: true,
                          length: { maximum: NAME_MAXIMUM_LENGTH }
    validates :link,      format:     { with: VALID_URL_REGAX, message: 'はhttpまたはhttpsを先頭にしてください。' }, if: :link_present?
    validates :introduce, length:     { maximum: INTRODUCE_MAXIMUM_LENGTH }
  end

  def assign_profile_attributes(name, introduce, link)
    self.name = name
    self.introduce = introduce
    self.link = link
  end

  scope :find_and_select_by_id, ->(id) {
    select(:id, :name, :introduce, :picture, :cover, :link).find(id)
  }
  
  delegate :present?, to: :link, prefix: true

  def assets_selected
    assets.select(:id, :file, :alt).order(created_at: :desc)
  end

  def cover_url
    cover.present? ? "#{BASE_URL}#{cover.url}" : nil
  end

  def picture_url
    picture.present? ? "#{BASE_URL}#{picture.url}" : nil
  end

  def star_blog_ids
    stars.order(created_at: :desc).pluck(:blog_id)
  end
end
