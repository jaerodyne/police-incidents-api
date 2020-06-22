Rails.application.routes.draw do
  root 'api/v1/incidents#index'
  
  namespace :api do
    namespace :v1 do
      resources :incidents, only: [:index, :show]
      get :sources, to: 'incidents#sources'
    end
  end
end
