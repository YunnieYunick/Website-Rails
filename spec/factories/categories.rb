FactoryGirl.define do
  factory :category do
    name { Faker::Name.name }
    slug { Faker::Name.name.downcase }

    factory :invalid_category do
      name nil
    end

    after(:build) do |category|
      category.posts << build(:post)
    end
  end
end
