Rails.application.routes.draw do
  resources :causes
  root "pages#home"
end
