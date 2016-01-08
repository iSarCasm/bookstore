FactoryGirl.define do
  factory :category do
    sequence(:id)   { |n| n }
    sequence(:name) { |n| Faker::Book.genre + n.to_s }
  end
end
