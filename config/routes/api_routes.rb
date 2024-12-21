module APIRoutes
  def self.extended(router)
    router.instance_exec do
      namespace :api do
        defaults format: :json do
          devise_scope :user do
            unauthenticated do
              # Simple public API to check health of API
              get "/health-check", to: "health_check#show"
              post "/sign-in", to: "sessions#create", as: :sessions
            end

            authenticated do

            end
          end
        end
      end
    end
  end
end
