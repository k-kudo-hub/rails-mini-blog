FactoryBot.define do
  factory :blog do
    user { nil }
    organization { nil }
    subject { 'MyString' }

    body { 'MyText' }
    cover_image { 'MyString' }
    state_number { 1 }
    url { 'MyString' }
  end
end
