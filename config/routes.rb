Rails.application.routes.draw do
  namespace :units, defaults: { format: :json } do
    resources :si, only: [:index]
  end

  root "welcome_pages#index"
end
