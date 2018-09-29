FactoryGirl.define do
  factory :tag do
    name { Faker::Lorem.characters(5) }

    factory :invalid_tag do
      name nil
    end
  end
end
