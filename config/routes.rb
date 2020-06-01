Rails.application.routes.draw do
  root 'incidents#index'
  
  resources :incidents, only: [:index, :show]
end
