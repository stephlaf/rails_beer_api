Rails.application.routes.draw do
  devise_for :users
  
  root to: 'pages#home'

  get 'beers/new/:upc', to: 'beers#new_upc', as: 'new_upc'

  resources :beers do
    post :get_barcode, on: :collection
    get :scan, on: :collection
    resources :beer_tabs, only: [:new, :create, :edit, :update]
  end

  resources :beer_tabs, only: [:index, :show, :destroy]

  resources :breweries, only: [:index, :show, :new, :create]

  resources :temp_beers, except: [:new, :edit, :update]
  get 'temp_beers/new/:upc', to: 'temp_beers#new', as: 'temp_new_upc'

  # API routes

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :beers, only: [:index, :show]
      get 'beers/search/:query', to: 'beers#search', as: 'search'

      resources :temp_beers, only: [:index, :create]
    end
  end

end
