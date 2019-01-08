Rails.application.routes.draw do

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  get 'about',  to: 'pages#about'
  get 'contact', to: 'pages#contact'

  resources :articles, except: [:show] do
    resources :comments
  end

  resources :articles do
    member do
      post :toggle_publish_status
    end
  end

  get 'articles/tags/:tag', to: 'articles#index', as: 'article_tag'
  get 'article/:id', to: 'articles#show', as: 'article_show'

  namespace :admin do
    get 'dashboard', to: 'dashboard#dashboard'

    # get 'users', to: 'users#list_users'

    get 'users', to: 'users#search_users', as: 'user_search'
    get 'users/:display_name', to: 'users#show', as: 'user_show'

    get 'find_user', to: 'users#find_by_display_name'

    patch 'user_add_role', to: 'users#add_role'
    patch 'user_remove_role', to: 'users#remove_role'
  end

  root to: 'articles#index'
end
