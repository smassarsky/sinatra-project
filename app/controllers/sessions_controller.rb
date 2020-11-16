class SessionsController < ApplicationController

  get '/signup' do
    redirect '/home' if is_logged_in?
    erb :'/sessions/signup'
  end

  post '/signup' do
    user = User.create(params[:user])
    if user.id
      session[:user_id] = user.id
      redirect '/dashboard'
    else
      redirect '/login'
    end
  end

  get '/login' do
    redir_dash_if_logged
    erb :'/sessions/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/dashboard'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/dashboard' do
    redir_login_if_not_logged
    erb :'/sessions/dashboard'
  end

end