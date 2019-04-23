Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "signup" => "users#signup"
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"
  get "users/:username" => "users#show"
  post "users" => "users#create"

  get "articles/new" => "articles#new"
  post "articles" => "articles#create"
  get "articles/:id/edit" => "articles#edit"
  patch "articles/:id" => "articles#update"
  delete "articles/:id" => "articles#delete"
end