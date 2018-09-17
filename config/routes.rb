Rails.application.routes.draw do

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

  root to: 'pages#home'
end
