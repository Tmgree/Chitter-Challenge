ENV['RACK_ENV'] = 'development'
require 'sinatra/base'
require_relative 'data_mapper_setup'
require 'sinatra/flash'

class Chitter < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash
  use Rack::MethodOverride

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

  get '/sessions/new' do
  erb :'sessions/new'
end

post '/sessions' do
  user = User.authenticate(params[:email], params[:password])
  if user
    session[:user_id] = user.id
    redirect to('/peeps/new')
  else
    flash.now[:errors] = ['The email or password is incorrect']
    erb :'sessions/new'
  end
end

delete '/sessions' do
  session[:user_id] = nil
  flash.keep[:notice] = 'goodbye!'
  redirect to '/'
end

  helpers do
 def current_user
   @current_user ||= User.get(session[:user_id])
 end
end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
