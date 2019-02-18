Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get("/", to: "homepage#index", as: :root)

  get("/contact_us", to: "homepage#contact")

  post("/contact_us/process", to: "homepage#process_contact", as: :process_contact)

  resource :session, only: [:new, :create, :destroy]
  resources :users

  resources :occurences, except: [:new, :create, :edit, :update, :destroy] do
    resources :bookings, shallow: true, only: [:create, :destroy]

    get :booked, on: :collection
  end

  resources :gym_classes do
    resources :occurences, only: [:new, :create, :index, :destroy]
  end
end
