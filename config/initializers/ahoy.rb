class Ahoy::Store < Ahoy::DatabaseStore
end

# set to true for JavaScript tracking
Ahoy.api = true
Ahoy.quiet = false
Ahoy.protect_from_forgery = false
Ahoy.track_bots = true