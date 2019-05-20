Rails.application.routes.draw do
  # # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#index'
  devise_for :users

  get 'users/:username/statistics' => 'user_statistics#index', as: :user_statistics
  post 'users/:username/statistics' => 'user_statistics#create', as: :user_statistic
  get 'users/:username/statistics/dounload/:id' => 'user_statistics#download', as: :user_statistic_download
  get 'users/:username/articles'=> 'articles#index', as: :user_page

  resources :articles do
    resources :comments, :only =>[
      :create, :edit, :update, :destroy
    ]
  end

  # letter_opener設定
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
