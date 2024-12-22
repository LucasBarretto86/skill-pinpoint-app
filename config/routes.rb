require_relative "routes/main_routes"
require_relative "routes/api_routes"

Rails.application.routes.draw do
  # LUCAS: Separate Route files just to make it cleaner
  extend MainRoutes
  extend APIRoutes
end
