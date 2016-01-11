class Address < ActiveRecord::Base
  validates :first_name, :last_name, :street_address,
            :city, :country, :zip, :phone,
            presence: true
end

class NullAddress < Address; end
