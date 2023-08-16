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

    # お気に入りリストに関連する本の一覧のためのルーティングを追加
    get 'books', on: :member

    # お気に入りリストから本を削除するためのルーティングを追加
    delete 'remove_book/:book_id', to: 'favorite_lists#remove_book', on: :member, as: :remove_book

  end

  get 'users/show', to: 'users#show', as: :custom_show_users
  get 'users/edit', to: 'users#edit', as: :custom_edit_users
  patch 'users/edit', to: 'users#update', as: :custom_update_users

end
