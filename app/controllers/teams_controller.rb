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
    if team.errors.messages.empty?
      redirect "/teams/#{team.id}"
    else
      redirect '/teams/new'
    end
  end

  #show
  get '/teams/:id' do
    redir_login_if_not_logged
    @team = Team.find(params[:id])
    if @team
      erb :'/teams/show'
    else
      redirect '/teams'
    end
  end

  #edit
  get '/teams/:id/edit' do
    redir_login_if_not_logged
    @team = Team.find(params[:id])
    redirect '/teams' if !owner?(@team)
    erb :'/teams/edit'
  end

  #update
  patch '/teams/:id' do
    redir_login_if_not_logged
    @team = Team.find(params[:id])
    if owner?(@team)
      @team.update(name: params[:team_name])
      redirect "/teams/#{params[:id]}"
    else
      redirect "/error/you-cannot-edit-that"
    end
  end

  #delete
  delete '/teams/:id' do
    redir_login_if_not_logged
    @team = Team.find(params[:id])
    if owner?(@team)
      @team.players.destroy_all
      @team.games.destroy_all
      @team.seasons.destroy_all
      @team.destroy
      redirect '/teams'
    else
      redirect '/error/you-cant-do-that'
    end
  end

end