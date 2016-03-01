FactoryGirl.define do
  factory :order do
    user
    association :payment,           factory: :payment_info
    association :billing_address,   factory: :address
    association :shipment_address,  factory: :address
    shipment
    aasm_state  'in_progress'
  end
end
