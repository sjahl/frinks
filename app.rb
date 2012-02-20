#!/usr/bin/env ruby
# Author: Stephen Jahl
# Filename: app.rb
# Description: a Sinatra app for storing links in a database

require 'sinatra'
require 'data_mapper'

# Database
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/frinks.db")

class Link
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :url, Text
  property :created_at, DateTime
end

# Visible Routes
get '/' do
  "Hello World!"
end

# API 
get '/api/time' do
  "#{Time.now}"
end

