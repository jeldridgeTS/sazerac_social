Rails.application.routes.draw do

  # devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  # Scoping here for devise paths
  scope module: :api, path: 'api', defaults: { format: :json } do
    scope module: :v1, path: 'v1' do
      devise_for :users, controllers: {
           registrations: 'api/v1/users/registrations',
       }, skip: [:sessions, :password]
    end
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resource :sessions, :only => [:create, :destroy]

      get 'logged_in', to: 'sessions#logged_in'
      get 'current_user', to: 'current_user#show', as: 'current_user'

      post 'articles', to: 'jank#create'
    end
  end

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

  get 'about',  to: 'pages#about'
  get 'contact', to: 'pages#contact'

  root to: 'pages#landing'
end
