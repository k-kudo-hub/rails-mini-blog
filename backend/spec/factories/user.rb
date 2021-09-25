FactoryBot.define do
  factory :user do
    name       { Faker::Name.initials(number: 2) }
    email      { Faker::Internet.free_email }
    password   { 'mini1234' }
    introduce  { 'Hello, world!!' }
    picture    { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/assets/images/git-logo-fire.png')) }
    cover      { 'dummy-header.png' }
    provider   {}
    uid        {}
    link       { 'https://www.error-note.com' }
  end
end
