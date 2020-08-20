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
end
