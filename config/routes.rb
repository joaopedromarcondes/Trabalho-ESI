Rails.application.routes.draw do
  devise_for :users
  resources :photos
  resources :audio_submissions, only: [:new, :create]
  root 'home#index'
  get "home/index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'noise_data', to: 'home#noise_data'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end


