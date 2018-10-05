Rails.application.routes.draw do
  namespace :admin do
    resource :imports, only: [:new, :create]
    resources :movements
    root to: "movements#index"
  end

  resources :movements, only: [:index]
  root to: "movements#index"
end
