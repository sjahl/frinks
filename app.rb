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
  @links = FrinkLink.all(:order => [ :id.desc ], :limit => 10)
  erb :index
end

get '/links/:id' do
  @link = FrinkLink.get(params[:id])
  erb :link
end

get '/new' do
  erb :add
end

# API 
get '/api/time' do
  "#{Time.now}"
end

post '/api/add' do
  @link = FrinkLink.create(
    :title => params[:title],
    :url => params[:url],
    :created_at => Time.now
  )
  redirect '/'
end
