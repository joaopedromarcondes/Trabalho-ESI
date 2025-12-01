require 'warden'

Warden.test_mode!

World(Warden::Test::Helpers)

After do
  Warden.test_reset!
end
