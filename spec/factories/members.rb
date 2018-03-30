FactoryGirl.define do
  factory :member do
    username 'Mick'
    email 'mick@mick.com'
    password 'secret'
    password_confirmation 'secret'
  end
end
