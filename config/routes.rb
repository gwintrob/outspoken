Outspoken::Application.routes.draw do
  resources :responses


  resources :dashboards


  resources :projects


  resources :videos


  # root :to => 'welcome#index'
  match 'auth/:provider/callback', :to => 'sessions#create'
  match 'auth/failure', :to => redirect('/')
  match 'signout', :to => 'sessions#destroy', :as => 'signout'

  resources :speeches
  resources :users

  root :to => 'users#index'
end
