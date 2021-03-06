require 'sextant/engine'
require 'rails/routes'

module Sextant

  begin
    require 'rails/application/route_inspector'
    ROUTE_INSPECTOR = Rails::Application::RouteInspector.new
  rescue LoadError
    require 'action_dispatch/routing/inspector'
    ROUTE_INSPECTOR = ActionDispatch::Routing::RoutesInspector.new([])
  end

  def self.format_routes(routes = all_routes)
    # ActionDispatch::Routing::RoutesInspector.new.collect_routes(_routes.routes)
    main_app_routes = ROUTE_INSPECTOR.send :collect_routes, routes
    engines_routes  = ROUTE_INSPECTOR.send :instance_variable_get, :@engines

    {main_app: main_app_routes, engines: engines_routes}
  end

  def self.all_routes
    Rails.application.reload_routes!
    Rails.application.routes.routes
  end
end

