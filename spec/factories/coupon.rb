FactoryGirl.define do
  factory :coupon do
    name      { Faker::Lorem.sentence(6).upcase }
    discount  { [0.10, 0.15, 0.20, 0.30].sample }
  end
end
