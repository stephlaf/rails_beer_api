Rails.application.routes.draw do
  root to: 'beers#index'

  get 'beers/new/:upc', to: 'beers#new_upc', as: 'new_upc'

  resources :beers do
    post :get_barcode, on: :collection
    get :scan, on: :collection
  end

  resources :breweries, only: [:index, :show, :new, :create]
end
