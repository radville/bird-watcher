ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

require 'nokogiri'
require 'open-uri'
require 'rack-flash'
require "rack/flash/test"
require './app/controllers/application_controller'
require_all 'app'