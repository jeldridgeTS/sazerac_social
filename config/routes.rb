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

  get 'admin/users', to: 'admins#list_users'

  root to: 'articles#index'
end
