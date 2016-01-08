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
end
