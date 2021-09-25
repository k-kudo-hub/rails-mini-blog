class Blog < ApplicationRecord
  require 'securerandom'
  extend Enumerize
  belongs_to :user

  mount_uploader :cover_image,   CoverUploader
  enumerize :state_number, in: { draft: 0, limited: 1, release: 2 }

  SUBJECT_MAXIMUM_LENGTH      = 50

  validates :subject,       presence:     true,
                            length:       { maximum: SUBJECT_MAXIMUM_LENGTH }
  validates :state_number,  numericality: { in: 0..2 }
  validates :url,           uniqueness:   { message: 'URL生成で問題が発生しました。お手数ですが再度「保存する」を押してください。' }, on: :create

  def set_url()
    self.url = self.random_url
  end

  def random_url
    return SecureRandom.hex(20)
  end

  def state_value
    state_number_value
  end
end
