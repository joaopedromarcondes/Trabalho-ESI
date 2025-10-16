# spec/support/capybara.rb

# Importante: Este require é necessário neste arquivo separado
require 'capybara/rspec'

# Registra nosso driver customizado
Capybara.register_driver :headless_chrome_with_location do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--disable-gpu')
  options.add_argument('--window-size=1280,800')
  options.add_preference('profile.default_content_setting_values.geolocation', 1)

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options
  )
end

# Define o driver para todos os testes que usam JavaScript
Capybara.javascript_driver = :headless_chrome_with_location

# Opcional, mas recomendado: força o uso deste driver como padrão para todos os testes
Capybara.default_driver = :headless_chrome_with_location