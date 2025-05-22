Rails.application.routes.draw do
  get 'search', to: 'search#index'

  resources :volunteers
  resources :gallery_images, except: [:show]
  resources :causes do 
    resources :comments, only: [:create]
    resources :payments, only: [:new, :create]
  end 
  
  root "pages#home"
  get 'contact', to: 'pages#contact'
  post '/webhooks_monopay', to: 'webhooks#monopay', as: :webhooks_monopay
  
end
