class Router
  attr_reader :routes

  def initialize(routes)
    @routes = routes
  end

  def resolve(env)
    path = env['REQUEST_PATH'] # 2

    if routes.has_key?(path)
      ctrl(routes[path]).call
    else
      BaseController.new.not_found
    end
  rescue StandardError => e
    puts e.message
    puts e.backtrace
    BaseController.new.internal_error
  end

  private

  def ctrl(str)
    ctrl_name, action_name = str.split('#')

    klass = Object.const_get("#{ctrl_name.capitalize}Controller")
    klass.new(name: ctrl_name, action: action_name)
  end
end
