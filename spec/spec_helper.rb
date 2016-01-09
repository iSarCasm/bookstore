require 'simplecov'
SimpleCov.start do
  coverage_dir('public/coverage')
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
    mocks.verify_doubled_constant_names = true
  end

  config.around(:each, verify_stubs: false) do |ex|
    config.mock_with :rspec do |mocks|
      mocks.verify_partial_doubles = false
      ex.run
      mocks.verify_partial_doubles = true
    end
  end

  config.disable_monkey_patching!

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  # config.profile_examples = 3

  config.order = :random
  Kernel.srand config.seed
end

def pagination_stub(some_model)
  allow(some_model).to receive(:total_pages).and_return(5)
  allow(some_model).to receive(:current_page).and_return(1)
  allow(some_model).to receive(:limit_value).and_return(1)
end
