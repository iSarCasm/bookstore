FactoryGirl.define do
  factory :author do
    transient do
      book_count 0 # wtf: if 1 = big bang
    end

    sequence(:id)   { |n| n }
    sequence(:name) { |n| Faker::Name.name + n.to_s }
    desc    { Faker::Lorem.sentence }
    born    { Faker::Date.between(60.years.ago, 20.years.ago) }
    country { Faker::Address.country }

    # wtf
    after(:build) do |author, evaluator|
      author.books = build_list(:book, evaluator.book_count)
    end
    after(:create) do |author, evaluator|
      author.books = create_list(:book, evaluator.book_count)
    end
  end

  factory :category do
    sequence(:id)   { |n| n }
    sequence(:name) { |n| Faker::Book.genre + n.to_s }
  end

  factory :book do
    transient do
      categories_count  0 # wtf: if 1 = big bang
      authors_count   0
    end

    sequence(:id)   { |n| n }
    sequence(:title) { |n| Faker::Book.title + n.to_s }
    desc        { Faker::Lorem.sentence }
    quantity    { rand(1..20) }
    price       { Faker::Number.decimal(2) }

    # wtf
    after(:build) do |book, evaluator|
      book.categories = build_list(:category, evaluator.categories_count)
      book.authors    = build_list(:author, evaluator.authors_count)
    end
    after(:create) do |book, evaluator|
      book.categories = create_list(:category, evaluator.categories_count)
      book.authors    = create_list(:author, evaluator.authors_count)
    end
  end
end
