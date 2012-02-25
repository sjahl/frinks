#!/usr/bin/env ruby
# Author: Stephen Jahl
# Filename: app.rb
# Description: a Sinatra app for storing links in a database

require 'sinatra'
require 'data_mapper'
require './config'


# Database
DataMapper::setup(:default, "sqlite3://#{DATABASE[:database_path]}")

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

get '/link/:id' do
  @link = FrinkLink.get(params[:id])
  erb :link
end

get '/link/:id/edit' do
  @link = FrinkLink.get(params[:id])
  erb :edit
end

get '/link/:id/delete' do
  @link = FrinkLink.get(params[:id])
  erb :delete
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

put '/api/edit/:id' do
  @link = FrinkLink.get(params[:id])
  @link.update(
    :title=> params[:title],
    :url => params[:url],
    :created_at => Time.now
  )
  redirect '/link/' + params[:id].to_s
end

delete '/api/delete/:id' do
  @link = FrinkLink.get(params[:id])
  @link.destroy
  redirect '/'
end
