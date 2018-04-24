FactoryGirl.define do
  factory :topic do
    sequence(:title) { |n| "New Topic #{n}" }
    sequence(:body) { |n| "new topic #{n}" }
    sequence(:slug) { |n| "new_topic #{n}" }
  end
end
