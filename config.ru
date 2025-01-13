# frozen_string_literal: true

require 'bundler/setup'

Bundler.require

require './app'

class TimeMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    start = Time.now

    status, headers, body = @app.call(env)

    finish = Time.now

    total_time = start - finish

    puts "----- [HTTP Request] status=#{status} time=#{total_time.to_s} -----"

    [status, headers, body]
  end
end

first_middleware = TimeMiddleware.new(App.new)

run first_middleware
