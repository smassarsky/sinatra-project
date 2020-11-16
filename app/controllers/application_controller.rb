require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect '/dashboard' if is_logged_in?
    erb :index
  end

  helpers do

    def current_user
      @user ||= User.find(session[:user_id])
    end

    def is_logged_in?
      !!session[:user_id]
    end

    def redir_login_if_not_logged
      redirect '/login' if !is_logged_in?
    end

    def redir_dash_if_logged
      redirect '/dashboard' if is_logged_in?
    end

  end

end