Rails.application.routes.draw do
 
 
  devise_for :users, controllers: {
    sessions: 'users/sessions', 
    registrations: 'users/registrations'
  }

  get '/users_details' => 'users#signed_in_user'
  resources :users
  resources :posts do
    member do
      get :find_post
    end
    resources :comments
  end

  
end
