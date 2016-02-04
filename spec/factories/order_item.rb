FactoryGirl.define do
  factory :order_item do
    order
    book
    quantity { Random.new.rand(1..9) }
  end
end
