ENV['RACK_ENV'] = 'development'
require 'sinatra/base'
require_relative 'data_mapper_setup'
require 'sinatra/flash'

class Chitter < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash

  get '/' do
    @peeps = Peep.all

    erb :'/index'
  end

  get '/peeps/new' do
    erb :'/peeps/new'
  end

  post '/peeps' do
    p params
    Peep.create(peep: params[:peep])
    redirect to ('/')
  end

  get '/users/new' do
    erb :'/users/new'
  end

  post '/users' do
    user = User.create(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    if user.save
    session[:user_id] = user.id
    redirect to ('/peeps/new')
  else
    flash.now[:notice] =  @user.errors.full_messages
    erb :'users/new'
  end
  end

  helpers do
 def current_user
   @current_user ||= User.get(session[:user_id])
 end
end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
