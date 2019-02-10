Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get("/", to: "homepage#index", as: :root)

  

  resources :users, only: [:new, :create]

  resources :gym_classes
end
