FactoryGirl.define do
  factory :work do
    start_datetime Time.now
    end_datetime Time.now + 2

    after(:build) do |work|
      work.store_id = create(:store).id
    end

  end
end
