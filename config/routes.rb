Outspoken::Application.routes.draw do
  # root :to => 'welcome#index'
  match 'auth/:provider/callback', :to => 'sessions#create'
  match 'auth/failure', :to => redirect('/')
  match 'signout', :to => 'sessions#destroy', :as => 'signout'

  resources :speeches
  resources :users

  root :to => 'users#index'
end