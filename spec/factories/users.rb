FactoryGirl.define do
  factory :user do
    username 'Ringo'
    email 'ringo@starr.com'
    password 'secret'
    password_confirmation 'secret'
    role 0

    factory :avator do
      avatar { Rack::Test::UploadedFile.new Rails.root.join('public/user.png'), 'image/png' }
    end

    after(:build) do |user|
      user.posts << build(:post, published: true, published_at: Time.now)
    end
  end
end
