require 'rubygems'
require 'bundler'

Bundler.require :default, :development

root = File.expand_path File.dirname(__FILE__)
require "#{root}/support/multi_schema"
require "#{root}/support/json_column"
require 'thinking_sphinx/railtie'

Combustion.initialize! :active_record

MultiSchema.new.create 'thinking_sphinx'

Dir["#{root}/support/**/*.rb"].each { |file| require file }

RSpec.configure do |config|
  # enable filtering for examples
  config.filter_run :wip => nil
  config.run_all_when_everything_filtered = true
end
