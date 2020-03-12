Rails.application.routes.draw do
  resources :access_requests
  resources :requests do
    resources :build, controller: 'requests/build'
  end
  resources :request_steps
  resources :permissions
  resources :end_users
  resources :roles
  resources :access_accounts
  devise_for :users, skip: [:sessions, :registrations]
  devise_scope :user do
    authenticated :user do
      root 'access_accounts#index', as: :authenticated_root
    end

    root 'devise/sessions#new'
    get '/sign_in' => 'devise/sessions#new', as: :new_user_session
    post '/sign_in' => 'devise/sessions#create', as: :user_session
    delete '/sign_out' => 'devise/sessions#destroy', as: :destroy_user_session

    get 'users/edit' => 'devise/registrations#edit', as: :edit_user_registration
    put 'users' => 'devise/registrations#update', as: :user_registration
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
