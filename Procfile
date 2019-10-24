web: bundle exec puma -C config/puma.rb
log: tail -f log/development.log
redis: redis-server
worker: bundle exec sidekiq -c 5 -L log/sidekiq.log -q default -q mailers