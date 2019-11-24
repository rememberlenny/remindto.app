# Route prefixes use a single letter to allow for vanity urls of two or more characters
Rails.application.routes.draw do

  get 'telemetry/track'
  get '/getting_started' => 'widget_maker#new', as: 'widget_maker'

  # if defined? Sidekiq
  #   require 'sidetiq/web'
  #   authenticate :user, lambda {|u| u.is_admin? } do
  #     mount Sidekiq::Web, at: '/admin/sidekiq/jobs', as: :sidekiq
  #   end
  # end

  # resources :charges

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin' if defined? RailsAdmin

  # Static pages
  match '/error'      => 'pages#error', via: [:get, :post], as: 'error_page'
  get '/rss'       => 'pages#medium', as: 'rss'
  get '/medium'       => 'pages#medium', as: 'medium'
  get '/hn'           => 'pages#medium', as: 'hn'
  get '/terms'        => 'pages#terms', as: 'terms'
  get '/privacy'      => 'pages#privacy', as: 'privacy'
  get '/about'        => 'pages#about', as: 'about'
  get '/optout'       => 'pages#optout', as: 'optout'
  get '/contact'      => 'pages#faq', as: 'contact'
  get '/dnt'          => 'pages#dnt', as: 'dnt'
  get '/news'         => 'pages#news', as: 'news'
  get '/pricing'      => 'pages#pricing', as: 'pricing'
  get '/help'         => 'pages#faq', as: 'help'
  get '/howtouse'     => 'pages#howtouse', as: 'howtouse'

  post '/optout'      => 'pages#optout_confirm', as: 'optout_confirm'

  # OAuth
  oauth_prefix = Rails.application.config.auth.omniauth.path_prefix
  get "#{oauth_prefix}/:provider/callback" => 'users/oauth#create'
  get "#{oauth_prefix}/failure" => 'users/oauth#failure'
  get "#{oauth_prefix}/:provider" => 'users/oauth#passthru', as: 'provider_auth'
  get oauth_prefix => redirect("#{oauth_prefix}/login")

  # Devise
  devise_prefix = Rails.application.config.auth.devise.path_prefix
  devise_for :users, path: devise_prefix,
    controllers: {registrations: 'users/registrations', sessions: 'users/sessions',
      passwords: 'users/passwords', confirmations: 'users/confirmations', unlocks: 'users/unlocks'},
    path_names: {sign_up: 'signup', sign_in: 'login', sign_out: 'logout'}
  devise_scope :user do
    get "#{devise_prefix}/after" => 'users/registrations#after_auth', as: 'user_root'
  end
  get devise_prefix => redirect('/a/signup')

  # User
  resources :users, path: 'u', only: :show do
    resources :authentications, path: 'accounts'
  end
  get '/home'       => 'dashboards#home',   as: 'user_home'
  get '/install'    => 'dashboards#install',   as: 'install'
  get '/feed'       => 'laters#index',      as: 'later_feed'
  get '/feed/old'   => 'laters#old_index',  as: 'later_old_feed'

  # Later
  get 'later/update'       => 'laters#update',  as: 'update_later'
  get ':account/later/new' => 'laters#new',     as: 'new_later'
  get ':account/later/:id' => 'laters#show',    as: 'show_later'
  get '/later/success'     => 'pages#success_later_update', as: 'success_later_update'

  # Account
  get   '/account/new'      => 'accounts#new',    as: 'new_account'
  post  '/account/new'      => 'accounts#create', as: 'create_account'
  patch  '/reminder/:id'      => 'accounts#update', as: 'update_account'
  get  '/reminder/:id'      => 'accounts#reminder', as: 'show_account'
  get  '/reminder/:id/edit'      => 'accounts#edit', as: 'edit_account'
  get  '/reminder/:id/signups'      => 'accounts#signups', as: 'signups_account'
  get  '/reminder/:id/integrations'      => 'accounts#integrations', as: 'integrations_account'
  get  '/reminder/:id/stats'      => 'accounts#stats', as: 'stats_account'
  get  '/reminder/:id/stats_data'      => 'accounts#stats_data', as: 'stats_data_account'
  post  '/account/change'   => 'accounts#change', as: 'change_user_account'

  get '/reminder/:id/webhook/new' => 'webhook#new', as: 'new_webhook'
  get '/reminder/:id/webhook/create' => 'webhook#create', as: 'create_webhook'
  get '/reminder/:id/webhook/:webhook_id/update' => 'webhook#update', as: 'update_webhook'
  get '/reminder/:id/webhook/:webhook_id/edit' => 'webhook#edit', as: 'edit_webhook'
  get '/reminder/:id/webhook/:webhook_id/delete' => 'webhook#delete', as: 'delete_webhook'


  get '/checkout'           => 'accounts#checkout', as: 'checkout'
  post '/checkout_subscription' => 'accounts#checkout_subscription', as: 'checkout_subscription'

  # Dummy preview pages for testing.
  get '/p/test' => 'pages#test', as: 'test'
  get '/p/email' => 'pages#email' if ENV['ALLOW_EMAIL_PREVIEW'].present?
  get '/p/email/:layout' => 'pages#email' if ENV['ALLOW_EMAIL_PREVIEW'].present?
  get '/sample/test'  => 'pages#sample'
  get '/install'      => 'pages#install'


  get 'robots.:format' => 'robots#index'

  get '/reminder_form/new' => 'widget_maker#new'
  post '/reminder_form' => 'widget_maker#create'
  get '/check_email' => 'widget_maker#check_email'
  post '/user/invite' => 'widget_maker#new_user_by_email_only'

  post '/ra/track' => 'telemetry#track'

  get '/widget/:id/button'    => 'widget#button'
  get '/widget/:id/init'      => 'widget#init_script'
  get '/widget/:id'           => 'widget#embed'
  get '/widget-page/:id'      => 'widget#embed_page'

  get '/service/oembed' => 'service#oembed', as: 'oembed'
  get '/f/:id' => 'reminder_form_page#show', as: 'reminder_form_page'

  root 'pages#home'
end
