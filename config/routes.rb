Rails.application.routes.draw do
  root to: "auth/logins#new"

  get 'login', to: 'auth/logins#new'
  post 'login', to: 'auth/logins#login'

  delete 'logout', to: 'auth/logins#destroy', as: 'logout'

  resources :users
end
