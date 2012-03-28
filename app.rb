#!/usr/bin/env ruby

require 'bundler/setup'
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
  property :description, Text
  property :created_at, DateTime
  property :is_starred, Boolean, :default => false
end

DataMapper.finalize
FrinkLink.auto_upgrade!

# Visible Routes
get '/' do
  @links = FrinkLink.all(:order => [ :id.desc ], :limit => 10)
  erb :index
end

get '/all' do
  @links = FrinkLink.all(:order => [ :id.desc ])
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

# API 

post '/api/add' do
  @link = FrinkLink.create(
    :title => params[:title],
    :url => params[:url],
    :description => params[:description],
    :created_at => Time.now
  )
  if @link.save
    redirect "/link/#{@link.id}"
  else
    redirect '/'
  end
end

put '/api/edit/:id' do
  @link = FrinkLink.get(params[:id])
  @link.update(
    :title => params[:title],
    :url => params[:url],
    :description => params[:description],
    :created_at => Time.now
  )
  if @link.save
    redirect '/link/' + params[:id].to_s
  else
    redirect '/'
  end
end

delete '/api/delete/:id' do
  @link = FrinkLink.get(params[:id])
  @link.destroy
  redirect '/'
end