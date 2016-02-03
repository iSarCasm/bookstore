FactoryGirl.define do
  factory :address do
    first_name      { Faker::Name.first_name }
    last_name       { Faker::Name.last_name }
    street_address  { Faker::Address.street_address }
    city            { Faker::Address.city }
    country         { Faker::Address.country }
    zip             { Faker::Address.zip }
    phone           { Faker::PhoneNumber.phone_number }
  end
end
