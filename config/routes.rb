Rails.application.routes.draw do
  root to: 'beers#index'

  resources :beers do
    post :get_barcode, on: :collection
  end
end
