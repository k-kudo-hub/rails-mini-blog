FactoryBot.define do
  require 'securerandom'
  factory :blog do
    association  :user
    subject      { Faker::Lorem.characters(number: 10) }
    body         { Faker::Lorem.characters(number: 40) }
    cover_image  { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/assets/images/dummy-header.jpg')) }
    state_number { Faker::Number.between(from: 0, to: 3) }
    url          { SecureRandom.hex(20) }
  end
end
