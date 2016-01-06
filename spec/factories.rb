FactoryGirl.define do
  factory :author do
    name    { Faker::Name.name }
    desc    { Faker::Lorem.sentence }
    born    { Faker::Date.between(60.years.ago, 20.years.ago) }
    country { Faker::Address.country }
  end

  factory :category do
    name { Faker::Book.genre }
  end

  factory :book do
    transient do
      category_count  1
      authors_count   1
    end

    title       { Faker::Book.title }
    desc        { Faker::Lorem.sentence }
    quantity    { rand(1..20) }
    price       { Faker::Number.decimal(2) }
    categories  { build_list(:category, category_count) }
    authors     { build_list(:author, authors_count) }
  end
end
