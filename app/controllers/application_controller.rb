require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  helpers do

    def current_user
      @user ||= User.find(session[:user_id])
    end

    def is_logged_in?
      !!session[:user_id]
    end

  end

end