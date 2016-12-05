Rails.application.routes.draw do

  resources :users

  root   'static#home'

  get    'about',   to: 'static#about'

  get    'faq',     to: 'static#faq'

  get    'contact', to: 'static#contact'

  get    'signup',  to: 'users#new'
  post   'signup',  to: 'users#create'
  get    'me',      to: 'users#show', as: 'profile'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
