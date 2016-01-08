FactoryGirl.define do
  factory :author do
    transient do
      book_count 1
    end

    sequence(:id)   { |n| n }
    sequence(:name) { |n| Faker::Name.name + n.to_s }
    desc    { Faker::Lorem.sentence }
    born    { Faker::Date.between(60.years.ago, 20.years.ago) }
    country { Faker::Address.country }

    after(:build) do |author, evaluator|
      if author.books.empty?
        author.books = build_list(:book,
          evaluator.book_count, authors: [author])
      end
    end
    after(:create) do |author, evaluator|
      if author.books.empty?
        author.books = create_list(:book,
          evaluator.book_count, authors: [author])
      end
    end
  end
end
