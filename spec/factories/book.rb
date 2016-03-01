FactoryGirl.define do
  factory :book do
    transient do
      categories_count  1
      authors_count     1
      category          nil
    end

    sequence(:id)   { |n| n }
    sequence(:title) { |n| Faker::Book.title + n.to_s }
    desc        { Faker::Lorem.sentence }
    quantity    { rand(1..20) }
    price       { Faker::Number.decimal(2) }

    after(:build) do |book, evaluator|
      if book.categories.empty?
        book.categories = build_list(:category,
          evaluator.categories_count, books: [book])
      end

      if book.authors.empty?
        book.authors    = build_list(:author,
          evaluator.authors_count, books: [book])
      end

      if evaluator.category
        build(:category_book, category: evaluator.category, book: book)
      end
    end

    after(:create) do |book, evaluator|
      if book.categories.empty?
        book.categories = create_list(:category,
          evaluator.categories_count, books: [book])
      end

      if book.authors.empty?
        book.authors    = create_list(:author,
          evaluator.authors_count, books: [book])
      end

      if evaluator.category
        create(:category_book, category: evaluator.category, book: book)
      end
    end
  end
end
