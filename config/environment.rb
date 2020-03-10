require "bundler/setup"
require "sinatra/activerecord"
require "pry"
Bundler.require

require_all 'app'

ENV['SINATRA_ENV'] ||= 'development'

ActiveRecord::Base.establish_connection(ENV['SINATRA_ENV'].to_sym)
ActiveRecord::Base.logger = nil

def prompt_instance
    TTY::Prompt.new
end