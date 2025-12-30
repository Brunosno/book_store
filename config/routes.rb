Rails.application.routes.draw do
  resources :authors, only: [:index, :create, :update, :show, :destroy]
  resources :addresses, only: [:index, :create, :update, :show, :destroy]
  resources :orders, only: [:index, :create, :update, :show, :destroy]
  resources :phones, only: [:index, :create, :update, :show, :destroy]
  resources :books, only: [:index, :create, :update, :show, :destroy]

  resources :users, only: [:index, :create, :update, :show, :destroy] do
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