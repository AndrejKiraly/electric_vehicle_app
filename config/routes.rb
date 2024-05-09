Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  #devise_for :devise_users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html


  get '/ev_stations', to: 'ev_stations#index'
  get '/ev_stations/:id', to: 'ev_stations#show'
  get '/planroute', to: 'ev_stations#show_polyline'
  get '/userstations', to: 'ev_stations#show_user_stations'

  post '/ev_stations', to: 'ev_stations#create'
  post '/ev_stations/multiple', to: 'ev_stations#create_multiple'

  put '/ev_stations/:id(.:format)', to: 'ev_stations#update'
  patch '/ev_stations/:id(.:format)', to: 'ev_stations#update'
  delete '/ev_stations/:id', to: 'ev_stations#destroy'
  
  get '/connections', to: 'connections#index'
  get '/connections/:id', to: 'connections#show'
  post '/connections', to: 'connections#create'
  put '/connections/:id(.:format)', to: 'ev_stations#update'
  patch '/connections/:id(.:format)', to: 'connections#update'
  delete '/connections/:id', to: 'connections#destroy'

  
  get '/webhook', to: 'webhook#index'
  post '/webhook', to: 'webhook#create'

  get '/enode_vehicles', to: 'enode_vehicles#index'
  get '/enode_vehicles/user_vehicles', to: 'enode_vehicles#user_vehicles'
  post '/enode_vehicles', to: 'enode_vehicles#create'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
