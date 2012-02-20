#!/usr/bin/env ruby
# Author: Stephen Jahl
# Filename: app.rb
# Description: a Sinatra app for storing links in a database

require 'sinatra'
require 'yaml'
require 'data_mapper'

# Database
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/frinks.db")

class FrinkLink
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :url, String
  property :created_at, DateTime
  property :is_starred, Boolean
end

DataMapper.finalize

FrinkLink.auto_upgrade!

# Visible Routes
get '/' do
  "Hello World"
end

# API 
get '/api/time' do
  "#{Time.now}"
end

