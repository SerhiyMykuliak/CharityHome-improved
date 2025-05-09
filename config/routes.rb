Rails.application.routes.draw do
  resources :causes do 
    resources :comments, only: [:create]
  end 
  root "pages#home"

end
