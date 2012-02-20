#!/usr/bin/env ruby
# Author: Stephen Jahl
# Filename: app.rb
# Description: a Sinatra app for storing links in a database

require 'sinatra'

get '/' do
  "Hello World!"
end

get '/api/time' do
  "#{Time.now}"
end

