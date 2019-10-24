# Load the Rails application.
require_relative 'application'

# Set ENV vars to defaults in application.yml
Rails.application.config.settings.env.each do |k, v|
  ENV[k] ||= (v.blank? ? '' : v.to_s)
end

# Initialize the Rails application.
Rails.application.initialize!
