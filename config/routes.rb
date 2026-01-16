Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # API routes will be defined here
      resources :authors
      resources :addresses
      resources :orders
      resources :phones
      resources :books

      resources :users do
        collection do
          post :find_user
        end
      end

      resources :auth do
        collection do
          post :login
          post :register
        end
      end
    end
  end
end