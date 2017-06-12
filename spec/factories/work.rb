FactoryGirl.define do
  factory :work do
    association :location, factory: :location
    association :api, factory: :api
  end
end