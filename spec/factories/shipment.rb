FactoryGirl.define do
  factory :shipment do
    name { "Some shipment #{Random.new.rand(1..99)}"}
    cost { Random.new.rand(3..15) }
  end
end
