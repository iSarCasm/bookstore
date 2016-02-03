FactoryGirl.define do
  factory :payment_info do
    user
    card              { 16.times.inject("") { |card, e| card + Random.new.rand(1..9).to_s } }
    expiration_year   { Random.new.rand(2015..2100) }
    expiration_month  { Random.new.rand(1..12) }
    cvv               { Random.new.rand(100..999) }
  end
end
