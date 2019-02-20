Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get("/", to: "occurences#index", as: :root)

  get("/contact_us", to: "homepage#contact")

  post("/contact_us/process", to: "homepage#process_contact", as: :process_contact)

  resource :session, only: [:new, :create, :destroy]
  resources :users

  resources :bookings, only: [:index] do
    resources :booking_archivings, only: [:create]
  end
  
  resources :occurences, except: [:new, :create, :edit, :update, :destroy] do
    resources :occurence_archivings, shallow: true, only: [:create]
    
    resources :bookings, shallow: true, only: [:create, :destroy] do
      resources :payments, shallow: true, only: [:new, :create]
    end

    get :booked, on: :collection
    get :archived_occurences, on: :collection
  end

  resources :gym_classes do
    resources :occurences, only: [:new, :create, :index, :destroy]
  end


  namespace :api, defaults: {format: :json} do 
    namespace :v1 do
      
      resource :session, only: [:create, :destroy]
      resources :users, only: [] do
        get :current, on: :collection
      end
      
      resources :bookings, only: [:index]  

      resources :occurences, except: [:new, :create, :edit, :update, :destroy] do
        
        resources :bookings, shallow: true, only: [:create, :destroy]

        get :booked, on: :collection
      end

      resources :gym_classes do
        resources :occurences, only: [:new, :create, :index, :destroy]
      end
    
    end
    match "*unmatched", via: :all, to: "application#not_found"
  end

end
