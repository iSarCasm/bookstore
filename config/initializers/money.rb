# encoding : utf-8

MoneyRails.configure do |config|

  # To set the default currency
  #
  config.default_currency = :usd

  # Set default bank object
  #
  # Example:
  # config.default_bank = EuCentralBank.new

  # Add exchange rates to current money bank object.
  # (The conversion rate refers to one direction only)
  #
  # Example:
  config.add_rate "USD", "UAH", 27
  config.add_rate "UAH", "USD", 0.04

  # To handle the inclusion of validations for monetized fields
  # The default value is true
  #
  # config.include_validations = true

  # Default ActiveRecord migration configuration values for columns:
  #
  # config.amount_column = { prefix: '',           # column name prefix
  #                          postfix: '_cents',    # column name  postfix
  #                          column_name: nil,     # full column name (overrides prefix, postfix and accessor name)
  #                          type: :integer,       # column type
  #                          present: true,        # column will be created
  #                          null: false,          # other options will be treated as column options
  #                          default: 0
  #                        }
  #
  # config.currency_column = { prefix: '',
  #                            postfix: '_currency',
  #                            column_name: nil,
  #                            type: :string,
  #                            present: true,
  #                            null: false,
  #                            default: 'USD'
  #                          }

  # Register a custom currency
  #
  # Example:
  config.register_currency = {
    :priority            => 1,
    :iso_code            => "UAH",
    :name                => "UAH",
    :symbol              => "грн",
    :symbol_first        => false,
    :subunit             => "Subcent",
    :subunit_to_unit     => 100,
    :thousands_separator => ".",
    :decimal_mark        => ","
  }

  # Set default money format globally.
  # Default value is nil meaning "ignore this option".
  # Example:
  #
  # config.default_format = {
  #   :no_cents_if_whole => nil,
  #   :symbol => nil,
  #   :sign_before_symbol => nil
  # }

  # Set default raise_error_on_money_parsing option
  # It will be raise error if assigned different currency
  # The default value is false
  #
  # Example:
  # config.raise_error_on_money_parsing = false
end
