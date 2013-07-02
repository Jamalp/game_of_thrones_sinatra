require 'pg'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'

set :database, {
    adapter: 'postgresql',
    database: 'westeros',
    host: 'localhost'
}

class House < ActiveRecord::Base
  has_many :people
end

class Person < ActiveRecord::Base
  belongs_to :house
end

# helpers do
#   # This helps us run SQL commands
#   def run_sql(sql)
#     db = PG.connect(dbname: 'westeros', host: 'localhost')
#     result = db.exec(sql)
#     db.close
#     result
#   end
# end

get '/' do
  @people = Person.all
  erb :index
end

get '/houses' do
  @houses = House.all
  erb :houses
end

get '/houses/new' do
  erb :new_house
end

post '/houses/new' do
  House.create(params)
  redirect to '/houses'
end

get '/people/new' do
  @houses = House.all
  erb :new_person
end

post '/people/new' do
  Person.create(params)
  redirect to '/people'
end

get '/people' do
  @people = Person.all
  erb :people
end

get '/people/:id' do
  id = params[:id]
  @people = Person.find(params[:id])
  erb :person
end

get '/houses/:id' do
  id = params[:id]
  @houses = House.find(params[:id])
  erb :house
end

get '/people/:id/edit' do
  @people = Person.find(params[:id])
  erb :edit
end

get '/houses/:id/edit' do
  @houses = House.find(params[:id])
  erb :edit
end