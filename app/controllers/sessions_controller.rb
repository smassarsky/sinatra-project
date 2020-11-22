class SessionsController < ApplicationController

  get '/signup' do
    redirect '/dashboard' if is_logged_in?
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
    @user = current_user
    erb :'/sessions/dashboard'
  end

  get '/error/:slug' do
    erb :'/sessions/error'
  end

  get '/join' do
    redir_login_if_not_logged
    erb :'/sessions/join'
  end

  post "/join" do
    redir_login_if_not_logged
    @code = PlayerCode.find_by(code: params[:code])
    if @code
      erb :'/sessions/confirm'
    else
      redirect '/error/invalid-code'
    end
  end

  post '/confirm_join' do
    redir_login_if_not_logged
    code = PlayerCode.find_by(code: params[:code])
    if code && code.status == "New"
      code.player.update(user: current_user)
      code.update(status: "Used")
      redirect "/teams/#{code.player.team.id}"
    else
      redirect '/error/invalid-code'
    end
  end

end