Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get("/", to: "homepage#index", as: :root)


  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]

  resources :occurences do
    resources :bookings, only: [:create, :destroy, :show, :index]
  end

  resources :gym_classes do
    resources :occurences, only: [:create, :destroy] do
      resources :bookings, only: [:create, :destroy, :show, :index]
    end
  end
end
