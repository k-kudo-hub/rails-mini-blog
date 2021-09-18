class Blog < ApplicationRecord
  require 'securerandom'
  extend Enumerize

  belongs_to :user

  enumerize :state_number, in: { draft: 0, limited: 1, release: 2 }

  def set_new_data()
    self.state_number = 0
    self.url = self.random_url
  end

  def random_url
    return SecureRandom.hex(20)
  end
end
