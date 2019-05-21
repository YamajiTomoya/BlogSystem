Rails.application.routes.draw do
  # # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#allocate'
  devise_for :users, only: [:sessions, :password]
  as :user do
    get 'users/sign_up', to: 'devise/registrations#new', as: :new_user_registration
    post 'users', to: 'devise/registrations#create', as: :user_registration
  end

  get 'users/:username/articles', to: 'articles#index', as: :user_page

  get 'users/:username/statistics', to: 'user_statistics#index', as: :user_statistics
  post 'users/:username/statistics', to: 'user_statistics#create', as: :user_statistic
  get 'users/:username/statistics/dounload/:id', to: 'user_statistics#download', as: :user_statistic_download


  resources :articles do
    resources :comments, only: [
      :create, :edit, :update, :destroy
    ]
  end

  # letter_opener設定
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
