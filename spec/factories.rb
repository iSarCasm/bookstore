FactoryGirl.define do
  factory :author do
    sequence(:name) { |n| Faker::Name.name + n.to_s }
    desc    { Faker::Lorem.sentence }
    born    { Faker::Date.between(60.years.ago, 20.years.ago) }
    country { Faker::Address.country }
  end

  factory :category do
    sequence(:name) { |n| Faker::Book.genre + n.to_s }
  end

  factory :book do
    transient do
      category_count  1
      authors_count   1
    end

    sequence(:title) { |n| Faker::Book.title + n.to_s }
    desc        { Faker::Lorem.sentence }
    quantity    { rand(1..20) }
    price       { Faker::Number.decimal(2) }

    # wtf
    after(:build) do |book, evaluator|
      book.categories = build_list(:category, evaluator.category_count)
      book.authors    = build_list(:author, evaluator.authors_count)
    end
    after(:create) do |book, evaluator|
      book.categories = create_list(:category, evaluator.category_count)
      book.authors    = create_list(:author, evaluator.authors_count)
    end
  end
end
