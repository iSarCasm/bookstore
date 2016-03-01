FactoryGirl.define do
  factory :category_book do
    association :book
    association :category
  end
end
