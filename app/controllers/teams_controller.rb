class TeamsController < ApplicationController

  #index
  get '/teams' do
    redir_login_if_not_logged
    @user = current_user
    erb :'/teams/index'
  end

  #new
  get '/teams/new' do
    redir_login_if_not_logged
    erb :'/teams/new'
  end

  #create
  post '/teams' do
    redir_login_if_not_logged
    team = Team.create(name: params[:team_name], owner: current_user)
    if team.id
      redirect "/teams/#{team.id}"
    else
      redirect '/teams/new'
    end
  end

  #show
  get '/teams/:id' do
    redir_login_if_not_logged
    @team = Team.find(params[:id])
    if exists_and_owner_or_teammate?(@team)
      erb :'/teams/show'
    end
  end

  #edit
  get '/teams/:id/edit' do
    redir_login_if_not_logged
    @team = Team.find(params[:id])
    if exists_and_owner?(@team)
      erb :'/teams/edit'
    end
  end

  #update
  patch '/teams/:id' do
    redir_login_if_not_logged
    @team = Team.find(params[:id])
    if exists_and_owner?(@team)
      @team.update(name: params[:team_name])
      redirect "/teams/#{params[:id]}"
    end
  end

  #delete
  delete '/teams/:id' do
    redir_login_if_not_logged
    @team = Team.find(params[:id])
    if exists_and_owner?(@team)
      @team.players.destroy_all
      @team.games.destroy_all
      @team.seasons.destroy_all
      @team.destroy
      redirect '/teams'
    end
  end

end