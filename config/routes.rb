Rails.application.routes.draw do

  # /api/v1
  scope module: :api, path: 'api', defaults: { format: :json } do
    scope module: :v1, path: 'v1' do
      devise_for :users, controllers: {
        registrations: 'api/v1/users/registrations',
      }, skip: [:sessions, :password]
    end

    devise_for :users, controllers: { registrations: 'api/v1/users/registrations' }, skip: [:sessions, :password]

    resource :sessions, :only => [:create, :destroy]
    get 'logged_in', to: 'sessions#logged_in'
    get 'current_user', to: 'current_user#show', as: 'current_user'

    resources :articles, except: [:new, :edit] do
      resources :comments, except: [:new, :edit]
      member { post :toggle_publish_status }
    end

    get 'articles/tags/:tag', to: 'articles#index', as: 'article_tag'
    get 'article/:id', to: 'articles#show', as: 'article_show'
  end

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
