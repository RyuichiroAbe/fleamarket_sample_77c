Rails.application.routes.draw do
  devise_for :users,controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'sending_destinations', to: 'users/registrations#new_sending_destinations'
    post 'sending_destinations', to: 'users/registrations#create_sending_destinations'
  end
  root to: "items#index"
  resources :items, only:[:show,:new, :create, :edit, :update, :destroy] do
    resources :favorites, only: [:index, :create, :destroy]
    resources :comments, only: :create
    collection do
      get 'category_children', defaults: { format: 'json' }
      get 'category_grandchildren', defaults: { format: 'json' }
      get 'search'
      get 'detail_search'
    end

    resource :purchases do
      member do
        get  "buy"
        post "pay"
      end
    end
  end
  resources :users, only: [:show]
  resources :cards, only: [:new, :create, :show, :destroy] do
  end
end