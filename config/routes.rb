Rails.application.routes.draw do
  root to: 'static_pages#show'

  namespace :admin do
    get '/dashboard', to: 'dashboard#show'
    get '/game_sessions/new', to: 'game_sessions#new'
    post '/game_sessions', to: 'game_sessions#create'
    get '/world_maps/new', to: 'world_maps#new'
    post '/world_maps', to: 'world_maps#create'
    get '/foundry_key', to: 'foundry_key#index'
    get '/foundry_key/:id/edit', to: 'foundry_key#edit', as: :edit_foundry_key
    patch '/foundry_key/:id', to: 'foundry_key#update', as: :update_foundry_key
    patch '/campaigns/:id/status', to: 'campaign_status#update'
    resources :world_news
    resources :campaigns
    resources :users, only: %i[index show edit update]
    patch '/user_status/:id', to: 'user_status#update', as: :user_status
  end

  get '/passwordless-login', to: 'sessions#passwordless_new', as: :passwordless_login
  post '/passwordless-login', to: 'sessions#passwordless_create', as: :passwordless_login_post
  get '/auth/:login_uuid', to: 'sessions#passwordless_return', as: :passwordless_return

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :monsters, only: %i[index show]
  resources :characters, only: %i[index show]

  get '/characters/:id/backstory/edit', to: 'backstory#edit', as: :backstory_edit
  patch '/characters/:id/backstory', to: 'backstory#update', as: :backstory_update

  resources :game_sessions, only: %i[index show] do
    resources :adventure_logs, only: %i[new create update]
  end

  get '/profile', to: 'users#show'
  resources :users, only: %i[new create] do
    resources :characters, only: %i[new create edit update]
    put '/character/:id/activate', to: 'characters#activate', as: :activate_character
  end
  patch '/status/:id', to: 'status#update', as: :status

  resources :world_news, only: %i[index show]
  resources :world_maps, only: %i[index]

  get '/hall-of-heroes', to: 'heroes#index'
end
