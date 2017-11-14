Rails.application.routes.draw do
  # Devise routes
  devise_for :users, controllers: {
    sessions: 'users/sessions', registrations: 'users/registrations'
  }
  # check user token route
  devise_scope :user do
    post 'check' => 'users/sessions'
  end
  # RailsAdmin routes
  mount RailsAdmin::Engine => '/adm_panel', as: 'rails_admin'
  api_version(:module => 'V1', :path => {:value => 'v2'}, :default => true) do
    # Add root route for api
    scope path: '/api' do
      resources :users, only: [:index, :destroy] do
      end
    end
  end

  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
