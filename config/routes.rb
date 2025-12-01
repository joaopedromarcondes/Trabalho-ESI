Rails.application.routes.draw do
  resources :health_symptoms
  devise_for :users, controllers: { sessions: 'users/sessions' }
  
  namespace :users do
    resource :profile, only: [:update]
    get 'activity', to: 'activity#index', as: 'activity'
  end
  
  resources :photos
  resources :audio_submissions, only: [:new, :create]
  root 'home#index'
  get "home/index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'noise_data', to: 'home#noise_data'
  get 'noise_history', to: 'noise_history#index'

  get 'heatmap', to: 'heatmaps#show'
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  resources :streaks, only: [:index]
  namespace :api do
    namespace :v1 do
      resources :streaks, only: [:index, :show] do
        collection do
          post :registrar_contribuicao
          post 'resetar/:tipo_atividade', action: :resetar, as: :resetar
        end
      end
    end
  end
end


