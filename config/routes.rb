Rails.application.routes.draw do

  get 'orders/new'

  get 'orders/edit'

  get 'orders/update'

  get 'orders/create'

  get 'orders/show'

  get 'password_resets/new'

  get 'password_resets/edit'

  #static controller routes
  root   'static#home'
  get    'about',   to: 'static#about'
  get    'faq',     to: 'static#faq'
  get    'contact', to: 'static#contact'

  #friendly user routes
  get    'signup',  to: 'users#new'
  post   'signup',  to: 'users#create'
  get    'me',      to: 'users#show', as: 'profile'

  get    'login',   to: 'sessions#new'
  post   'login',   to: 'sessions#create'
  delete 'logout',  to: 'sessions#destroy'

  #RESTful resources
  resources :users, :stores
  resource  :users, :stores
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
