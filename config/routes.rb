Rails.application.routes.draw do
  # LUCAS: I don't like endpoints of sign-in, sign-out, etc... to status scoped by user /users/sign_in
  devise_for :users, path: "", path_names: {
    sign_in: "/sign-in",
    sign_out: "/sign-out",
    sign_up: "/sign-up"
  }, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # LUCAS: Make devise sign_in route as root just to make things easier
  devise_scope :user do
    unauthenticated do
      root to: "users/sessions#new", as: :unauthenticated
    end

    authenticated do
      root to: "home#index", as: :home
    end
  end
end
