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
    member do
      post :post
      get 'edit_name'
      patch 'update_name'
      post 'add_book'
      get 'books'
      delete 'remove_book/:book_id', to: 'favorite_lists#remove_book', as: :remove_book
    end
  end

  resources :users, only: [:show, :edit, :update] do 
    member do
      post 'follow', to: 'users#follow'
      delete 'unfollow', to: 'users#unfollow'
      get 'following', to: 'users#following'
      get 'followers', to: 'users#followers'
    end
  end

  resources :posts, only: [:index]
end
