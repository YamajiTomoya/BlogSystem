Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "users#login_form", as: :login_form
  get "signup" => "users#signup"
  post "login" => "users#login"
  post "logout" => "users#logout"
  get "users/:username" => "users#show"
  get "users/:username/articles" => "articles#index", as: :user_page
  post "users" => "users#create"

  resources :articles do
    # comment[s]じゃないとform_withが動きません
    post "comments" => "comments#create"
  end

  delete "comment/:id" => "comments#destroy", as: :comment_delete
end
