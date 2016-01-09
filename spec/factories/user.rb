FactoryGirl.define do
  factory :user do
    sequence(:email)    { |n| n.to_s + Faker::Internet.email }
    password            { Faker::Internet.password(8) }
    confirmed_at        { Time.zone.now }
  end
end
