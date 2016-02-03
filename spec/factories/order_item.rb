FactoryGirl.define do
  factory :order do
    order
    book
    quantity { Random.new.rand(1..9) }
  end
end
