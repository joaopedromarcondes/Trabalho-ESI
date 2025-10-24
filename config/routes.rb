Rails.application.routes.draw do
  devise_for :users
  resources :photos
  resources :audio_submissions, only: [:new, :create]
  root 'home#index'
  get "home/index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end

Rails.application.routes.draw do
  root 'home#index'

  # Endpoint para retornar dados de ruído em JSON
  get 'noise_data', to: 'home#noise_data'

  devise_for :users
  resources :photos
end
