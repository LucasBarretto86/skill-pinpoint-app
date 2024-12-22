module APIRoutes
  def self.extended(router)
    router.instance_exec do
      namespace :api do
        defaults format: :json do
          devise_scope :user do
            # Simple public API to check health of API
            get "/health-check", to: "health_check#show"
            post "/sign-in", to: "sessions#create", as: :sessions

            resources :surveys, only: [:index]
          end
        end
      end
    end
  end
end
