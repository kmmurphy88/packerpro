Rails.application.routes.draw do

  resources :packlists
  
  root 'packlists#new'

end
