require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AuthApiTemplate
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # RACK CORS gem config
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '/check.json', headers: :any, methods: [:post, :options]
        resource '/users/sign_in.json', headers: :any, methods: [:post], expose: ['Authorization']
        resource '/users/sign_out.json', headers: :any, methods: [:delete]
        resource '/users.json', headers: :any, methods: [:post], expose: ['Authorization']
        # origins '*'
        # resource '*', headers: :any, methods: [:get, :post, :options]]
      end
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
