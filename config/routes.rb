Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Root route - landing page
  root "applications#new"
  
  # Application routes
  resources :applications, only: [:new, :create] do
    member do
      get :verify
    end
  end
  
  # Status lookup route
  get "status/:token", to: "applications#show", as: :application_status
  
  # Email verification route
  get "verify/:token", to: "applications#verify", as: :verify_email
  
  # Admin routes
  namespace :admin do
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    
    root 'applications#index'
    resources :applications, only: [:index, :show] do
      member do
        patch :approve
        patch :reject
      end
      
      collection do
        patch :bulk_update
      end
    end
    
    resources :matches, only: [:index, :create]
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
