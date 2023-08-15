Rails.application.routes.draw do
  root to: 'books#index'
  
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :books do
    collection do
      get 'search_online'
      get 'search_scanner'
    end
  end

  resources :favorite_lists do
    post 'add_book', on: :member
  end

  get 'users/show', to: 'users#show', as: :custom_show_users
  get 'users/edit', to: 'users#edit', as: :custom_edit_users
  patch 'users/edit', to: 'users#update', as: :custom_update_users

end
