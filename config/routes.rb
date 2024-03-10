Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
   root "home#index"

   get '/users/customers', to: 'users#customers', as: 'customers'
   get '/users/delivery_partners', to: 'users#delivery_partners', as: 'delivery_partners'
   delete '/users/:id/offboard', to: 'users#offboard', as: 'offboard_customer'
   post :onboard, to: 'users#onboard'
   get '/onboard', to: 'users#onboard_form', as: 'onboard_form'
   resources :shipments
   get '/delivery_partner/shipments', to: 'shipments#delivery_partner_index', as: 'delivery_partner_shipments'

   devise_scope :user do  
      get '/users/sign_out' => 'devise/sessions#destroy'     
  end
end
