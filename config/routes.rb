Rails.application.routes.draw do
  devise_for :users
  mount Maily::Engine, at: '/maily'
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
  
  get 'robots.:format' => 'robots#index'

  get '/service/oembed' => 'service#oembed', as: 'oembed'
  get '/f/:id' => 'reminder_form_page#show', as: 'reminder_form_page'

  root 'pages#home'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
