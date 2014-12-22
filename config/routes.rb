Rails.application.routes.draw do
  devise_for :users
  resources :packlists

  root 'packlists#new'

end
