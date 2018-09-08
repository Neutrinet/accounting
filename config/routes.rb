Rails.application.routes.draw do
  namespace :admin do
    resource :imports, only: [:new, :create]
    resources :movements, only: [:index]
  end
end
