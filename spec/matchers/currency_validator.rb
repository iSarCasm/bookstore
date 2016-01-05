RSpec::Matchers.define :validate_currency_of do |attribute|
  match do |actual|
    validates_valid = -> {
      actual.send("#{attribute}=", 3.33)
      actual.valid?
      actual.errors[attribute].empty?
    }.call

    validates_invalid = -> {
      actual.send("#{attribute}=", 3.333)
      actual.valid?
      actual.errors[attribute].any?
    }.call && -> {
      actual.send("#{attribute}=", 3.3)
      actual.valid?
      actual.errors[attribute].any?
    }

    validates_valid && validates_invalid
  end

  failure_message do |actual|
    "expected #{attribute} to be float with precision of 2"
  end
end
