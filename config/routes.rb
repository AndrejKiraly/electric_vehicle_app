

Rails.application.routes.draw do
  
  
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    passwords: 'overrides/passwords'
  }
  
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

 

      
  

#SERVER ROUTE https://electric-vehicle-app.onrender.com
  get '/ev_stations', to: 'ev_stations#index'
  get '/ev_stations/:id', to: 'ev_stations#show'
  get '/user/ev_stations/:page', to: 'ev_stations#show_user_stations'
  get '/ev_stations/:id/chargings', to: 'ev_stations#show_chargings_for_station'
  get '/ev_stations/:id/connections', to: 'ev_stations#show_connections_for_station'

  post '/ev_stations', to: 'ev_stations#create'
  post '/ev_stations/multiple', to: 'ev_stations#create_multiple'

  put '/ev_stations/:id(.:format)', to: 'ev_stations#update'
  patch '/ev_stations/:id(.:format)', to: 'ev_stations#update'
  delete '/ev_stations/:id', to: 'ev_stations#destroy'
  delete '/ev_stations', to: 'ev_stations#destroy_multiple'
  
  get '/connections', to: 'connections#index'
  get '/connections/:id', to: 'connections#show'
  post '/connections', to: 'connections#create'
  put '/connections/:id(.:format)', to: 'ev_stations#update'
  patch '/connections/:id(.:format)', to: 'connections#update'
  delete '/connections/:id', to: 'connections#destroy'

  
  get '/webhooks', to: 'webhooks#index'
  post '/webhooks', to: 'webhooks#create'

  get '/enode_vehicles/user', to: 'enode_vehicles#show_user_vehicles'
  get '/enode_vehicles/:id(.:format)', to: 'enode_vehicles#show_vehicle'
  post '/enode_vehicles', to: 'enode_vehicles#create'
  delete '/enode_vehicles', to: 'enode_vehicles#delete'


  get '/chargings', to: 'chargings#index'
  get '/chargings/:id', to: 'chargings#show'
  get '/chargings/monthly/:year/:month', to: 'chargings#monthly_summary'
  post '/chargings', to: 'chargings#create'
  patch '/chargings/:id', to: 'chargings#update'
  delete '/chargings/:id', to: 'chargings#destroy'
  get  '/chargings/:id/nearby_ev_stations', to: 'ev_stations#show_stations_close_to_charging'
  get '/chargings/:id/station', to: 'chargings#show_station_from_charging'
  get 'pages/success', to: 'pages#success', as: 'success'




  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
