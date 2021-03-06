Rails.application.routes.draw do
  # Devise routes
  devise_for :users, controllers: {
    sessions: 'users/sessions', registrations: 'users/registrations'
  }
  # check user token route
  devise_scope :user do
    post 'check' => 'users/sessions'
    post 'sign_in_with_vk' => 'users/sessions'
  end
  # RailsAdmin routes
  mount RailsAdmin::Engine => '/adm_panel', as: 'rails_admin'
  api_version(:module => 'V1', :path => {:value => 'v2'}, :default => true) do
    # Add root route for api
    scope path: '/api' do
      resources :social_accounts, only: [:index, :destroy] do
      end
      resources :users, only: [:index, :destroy] do
        post 'invite', on: :collection
        post 'add_social_account', on: :collection
      end
      resources :user_invites, only: [:index, :destroy] do
        post 'registration', on: :collection
      end
    end
  end

  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
