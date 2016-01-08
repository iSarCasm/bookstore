FactoryGirl.define do
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
