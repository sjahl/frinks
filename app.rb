#!/usr/bin/env ruby
# Author: Stephen Jahl
# Filename: app.rb
# Description: a Sinatra app for storing links in a database

require 'sinatra'
require 'data_mapper'

# Database
#
# Visible Routes
get '/' do
  "Hello World"
end

# API 
get '/api/time' do
  "#{Time.now}"
end

