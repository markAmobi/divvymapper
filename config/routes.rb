Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'stations#index'
  root 'map#map'

  get 'test', to: 'welcome#index'
  get 'stations', to: 'stations#index'
  get 'stations/:id', to: 'stations#show', as: 'station'
  get 'map', to: 'map#map', as: 'map'
  get 'map/:station_id', to: 'map#station'
end
