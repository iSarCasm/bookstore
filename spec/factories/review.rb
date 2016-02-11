FactoryGirl.define do
  factory :review do
    user
    book
    rating  { Random.new.rand(0..5) }
    message { Faker::Lorem.sentence }
    approved false
  end
end
