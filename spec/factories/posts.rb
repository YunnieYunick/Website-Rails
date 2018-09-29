FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.characters(5) }
    body { Faker::Lorem.sentences }

    factory :published do
      published true
    end
    
    factory :unpublished do
      published false
    end

    factory :post_en do
      locale :en
    end
  end
end
