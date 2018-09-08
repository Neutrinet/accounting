Rails.application.routes.draw do
  namespace :admin do
    resource :imports, only: [:new, :create]
  end
end
