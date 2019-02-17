Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get("/", to: "homepage#index", as: :root)


  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]

  resources :occurences do
    resources :bookings, shallow: true, only: [:create, :destroy]

    get :booked, on: :collection
  end

  resources :gym_classes do
    resources :occurences, only: [:new, :create, :show, :index, :destroy]
  end
end
