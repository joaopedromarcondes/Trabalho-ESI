module DeviseRequestSpecHelpers
  include Warden::Test::Helpers

  def sign_in(resource)
    scope = resource.class.name.underscore.to_sym
    login_as(resource, scope: scope)
  end

  def sign_out(resource)
    scope = resource.class.name.underscore.to_sym
    logout(scope)
  end
end

RSpec.configure do |config|
  config.include Warden::Test::Helpers
  config.include DeviseRequestSpecHelpers, type: :feature
  config.include DeviseRequestSpecHelpers, type: :request
  config.after :each do
    Warden.test_reset!
  end
end