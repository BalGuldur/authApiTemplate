Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/adm_panel', as: 'rails_admin'
  api_version(:module => 'V1', :path => {:value => 'v2'}, :default => true) do
    # Add root route for api
    scope path: '/api' do
    end
  end

  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
