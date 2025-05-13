Rails.application.routes.draw do
  resources :volunteers
  resources :causes do 
    resources :comments, only: [:create]
    resources :payments, only: [:new, :create]
  end 
  root "pages#home"

  post '/webhooks_monopay', to: 'webhooks#monopay', as: :webhooks_monopay
  
end
