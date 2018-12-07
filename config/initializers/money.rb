# frozen_string_literal: true

MoneyRails.configure do |config|
  config.default_currency = :usd
end

Money.locale_backend = :i18n
I18n.locale = :en
