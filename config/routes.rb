Rails.application.routes.draw do
  namespace :admin do
    resource :imports, only: [:new, :create]
    resources :movements, only: [:index, :edit, :update]
    root to: "movements#index"
  end

  resources :movements, only: [:index]
  root to: "movements#index"
end
