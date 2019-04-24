Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :articles
  get "signup" => "users#signup"
  get "/" => "users#login_form", as: :login_form
  post "login" => "users#login"
  post "logout" => "users#logout"

  get "users/:username" => "users#show", as: :user_page
  post "users" => "users#create"

  post "articles/:id/comment" => "comments#create", as: :comment_create
  delete "articles/:id/comment" => "comments#destroy", as: :comment_delete
end