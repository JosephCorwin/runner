Rails.application.routes.draw do

  resources :users

  root 'static#home'

  get 'about', to: 'static#about'

  get 'faq', to: 'static#faq'

  get 'contact', to: 'static#contact'

  get 'signup', to: 'users#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
