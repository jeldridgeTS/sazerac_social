Rails.application.routes.draw do

  get 'about',  to: 'pages#about'
  get 'contact', to: 'pages#contact'

  resources :articles, except: [:show] do
    resources :comments
  end

  get 'article/:id', to: 'articles#show', as: 'article_show'

  root to: 'pages#home'
end
