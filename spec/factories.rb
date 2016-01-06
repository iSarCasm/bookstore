FactoryGirl.define do
  factory :author do
    name { Faker::Name.name }
    desc { Faker::Lorem.sentence }
    born { Faker::Date.between(60.years.ago, 20.years.ago) }
    country { Faker::Address.country }
  end

  factory :category do
    name { Faker::Book.genre }
  end

  factory :book do
    title { Faker::Book.title }
    desc  { Faker::Lorem.sentence }
    quantity { rand(1..20) }
    price { Faker::Number.decimal(2) }
    category
    author
  end
end
