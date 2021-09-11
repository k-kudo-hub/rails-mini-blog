class User < ApplicationRecord
  has_secure_password

  VALID_EMAIL_REGEX        = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PASSWORD_REGAX     = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,100}+\z/i
  VALID_URL_REGAX          = /\A#{URI::regexp(%w(http https))}\z/
  NAME_MAXIMUM_LENGTH      = 20
  INTRODUCE_MAXIMUM_LENGTH = 250

  # TODO: Rails側のi18nが設定でき次第, message部分を削除する。
  validates :name,      presence:   { message: "が入力されていません。" }
  validates :name,      length:     { maximum: NAME_MAXIMUM_LENGTH, message: "は#{NAME_MAXIMUM_LENGTH}文字以内で登録できます。" }
  validates :email,     presence:   { message: "が入力されていません。" }, on: :create
  validates :email,     format:     { with: VALID_EMAIL_REGEX, message: 'に「@」が含まれていません。' }, on: :create
  validates :email,     uniqueness: { message: "はすでに使用されています。" }, on: :create
  validates :password,  presence:   { message: "が入力されていません。" }, on: :create
  validates :password,  format:     { with: VALID_PASSWORD_REGAX, message: 'は8文字以上の半角英数字混合で登録できます。' }, on: :create
  validates :link,      format:     { with: VALID_URL_REGAX , message: 'はhttpまたはhttpsを先頭にしてください。' }
  validates :introduce, length:     { maximum: INTRODUCE_MAXIMUM_LENGTH, message: "は#{INTRODUCE_MAXIMUM_LENGTH}文字以内で登録できます。" }

  scope :find_and_select_by_id, ->(id) {
    select(:id, :name, :introduce, :picture, :cover, :link).find(id)
  }
end
