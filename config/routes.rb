Rails.application.routes.draw do
  # # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root "users#index"
  get "users/:username/articles" => "articles#index", as: :user_page
  resources :articles do
    # comment[s]じゃないとform_withが動きません
    post "comments" => "comments#create"
  end
  
  resources :comments, :only =>[
    :edit, :update, :destroy
  ]

  # letter_opener設定
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
