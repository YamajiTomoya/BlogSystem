Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :articles do
    # comment[s]じゃないとform_withが動きません
    post "comments" => "comments#create"
  end
  get "signup" => "users#signup"
  get "/" => "users#login_form", as: :login_form
  post "login" => "users#login"
  post "logout" => "users#logout"

  get "users/:username" => "users#show", as: :user_page
  post "users" => "users#create"

  delete "comment/:id" => "comments#destroy", as: :comment_delete
  
end
