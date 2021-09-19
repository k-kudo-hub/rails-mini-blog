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

  def set_url()
    self.url = self.random_url
  end

  def random_url
    return SecureRandom.hex(20)
  end
end
