Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'stations#index'

  get 'stations', to: 'stations#index'
  get 'stations/:id', to: 'stations#show', as: 'station'

  get 'map', to: 'map#map', as: 'map'

end
