# frozen_string_literal: true

require 'yaml'
require 'byebug'

# Load routes
ROUTES = YAML.safe_load(File.open(File.join(__dir__, 'app', 'routes.yml')))

# Connect to tb db using Sequel
db_config_file = File.join(__dir__, 'app', 'database.yml')
if File.exist?(db_config_file)
  config = YAML.safe_load(File.open(db_config_file))['default']
  DB = Sequel.connect("#{config['adapter']}://#{config['database']}")
  Sequel.extension :migration
end

# Require lib and app files
Dir[File.join(__dir__, 'lib', '*.rb')].sort.each { |file| require(file) }
Dir[File.join(__dir__, 'app', '**', '*.rb')].sort.each { |file| require(file) }

# Run migrations
if DB
  Sequel::Migrator.run(DB, File.join(__dir__, 'app', 'db', 'migrations'))
end

class App
  attr_reader :router

  def initialize
    @router = Router.new(ROUTES)
  end

  def self.root
    __dir__
  end

  def call(env)
    result = router.resolve(env)

    [result.status, result.headers, result.content]
  end
end
