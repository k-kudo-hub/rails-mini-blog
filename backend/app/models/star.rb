class Star < ApplicationRecord
  belongs_to :user
  belongs_to :blog

  validate :check_own_star
  validate :check_unreleased_blog

  # 自分のブログはスターできない
  def check_own_star
    errors.add(:blog, ': 自分で書いたブログはスターできません。') if blog.user_id == user.id
  end

  # 下書き・限定公開・削除済みのブログはスターできない
  def check_unreleased_blog
    errors.add(:blog, ': 公開されていないブログはスターできません。') if blog.state_number_value != 2
  end
end
