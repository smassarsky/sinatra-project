class TeamsController < ApplicationController

  get '/teams' do
    redir_login_if_not_logged
    @user = current_user
    erb :'/teams/index'
  end

  get '/teams/new' do
    redir_login_if_not_logged
    erb :'/teams/new'
  end

  post '/teams' do
    team = Team.create(name: params[:team_name], owner: current_user)
    binding.pry
    if team.errors.messages.empty?
      redirect "/teams/#{team.id}"
    else
      redirect '/teams/new'
    end
  end

  get '/teams/:id' do
    redir_login_if_not_logged
    @team = Team.find(params[:id])
    if @team
      erb :'/teams/show'
    else
      redirect '/teams'
    end
  end

  get '/teams/:id/edit' do
    redir_login_if_not_logged
    @team = Team.find(params[:id])
    redirect '/teams' if current_user != @team.owner
    erb :'/teams/edit'
  end

  patch '/teams/:id' do
    puts params
    @team = Team.find(params[:id])
    if current_user == @team.owner
      @team.update(name: params[:team_name])
      redirect "/teams/#{params[:id]}"
    else
      redirect "/error/you-cannot-edit-that"
    end
  end

  delete '/teams/:id' do

  end

end