Rails.application.routes.draw do

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  namespace :api do
    namespace :v1 do
      resources :users, :only => [:show, :create, :update, :destroy]
      resources :sessions, :only => [:create, :destroy]
    end
  end

  get 'about',  to: 'pages#about'
  get 'contact', to: 'pages#contact'

  resources :articles, except: [:show] do
    resources :comments, except: [:show]
    member do
      post :toggle_publish_status
    end
  end

  get 'articles/tags/:tag', to: 'articles#index', as: 'article_tag'
  get 'article/:id', to: 'articles#show', as: 'article_show'

  namespace :admin do
    get 'dashboard', to: 'dashboard#dashboard'
    resources :users do
      member do
        patch :add_role
        patch :remove_role
      end
    end
  end

  root to: 'pages#landing'
end
