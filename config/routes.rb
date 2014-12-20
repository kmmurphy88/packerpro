Rails.application.routes.draw do

  resources :users

  resources :packlists do
  	post '/send_list', to: 'packlists#send_list', as: :send_list
  end
  

  root 'packlists#new'

end
