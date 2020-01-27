require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Remindtoapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.generators do |g|
      g.template_engine :erb
    end

    ActionMailer::Base.smtp_settings = {
      :user_name => Rails.application.credentials.sendgrid_user,
      :password => Rails.application.credentials.sendgrid_pass,
      :domain => Rails.application.credentials.sendgrid_domain,
      :address => 'smtp.sendgrid.net',
      :port => 465,
      :authentication => :plain,
      :enable_starttls_auto => true
    }
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :options]
      end
    end
  end
end

require File.expand_path('../settings', __FILE__)
