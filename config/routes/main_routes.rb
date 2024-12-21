module MainRoutes
  def self.extended(router)
    router.instance_exec do
      get "up", to: "rails/health#show", as: :rails_health_check

      # LUCAS: I don't like endpoints of sign-in, sign-out, etc... to status scoped by user /users/sign_in
      devise_for :users, path: "",
        path_names: { sign_in: "/sign-in", sign_out: "/sign-out", sign_up: "/sign-up" },
        controllers: { sessions: 'users/sessions', registrations: 'users/registrations', }

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
  end
end
