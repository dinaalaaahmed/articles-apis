Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :articles
      resource :users
      post "/users/sign-up", to: "authentication#create"
      post "/users/login", to: "authentication#login"
      get "users", to: "users#index"
    end

  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
