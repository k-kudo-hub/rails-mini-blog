class User < ApplicationRecord
  has_secure_password

  with_options presence: { message: "が入力されていません。" } do
    validates :name
    validates :email
    validates :password
  end

  validates :email, uniqueness: { message: "はすでに使用されています。" }
end
