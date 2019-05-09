Rails.application.routes.draw do
  # # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root "users#index"
  get "users/:username/articles" => "articles#index", as: :user_page
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
