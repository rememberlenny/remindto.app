Sidekiq.configure_server do |config|
  Sidekiq::Extensions.enable_delay!
end

Sidekiq.configure_client do |config|
  Sidekiq::Extensions.enable_delay!
end