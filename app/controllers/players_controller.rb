class PlayersController < ApplicationController

  #index
  get '/teams/:id/players' do
    redir_login_if_not_logged
    @team = Team.find(params[:id])
    if @team && owner_or_teammate?(@team)
      erb :'/players/index'
    else
      redirect '/error/you-cant-view-this-team'
    end
  end

  #new
  get '/teams/:id/players/new' do
    redir_login_if_not_logged
    @team = Team.find(params[:id])
    if owner?(@team)
      erb :'/players/new'
    else
      redirect '/error/you-cant-do-that'
    end
  end

  #create
  post '/teams/:id/players' do
    redir_login_if_not_logged
    team = Team.find(params[:id])
    if !owner?(team)
      redirect '/error/you-cant-do-that'
    elsif !positions.include?(params[:position])
      redirect '/error/invalid-position'
    else
      player = Player.create(name: params[:name], team: team, position: params[:position], jersey_num: params[:jersey], status: params[:active] ? "active" : "inactive")
      if player.errors.messages.empty?
        redirect "/teams/#{params[:id]}"
      else
        redirect '/error/something-went-wrong'
      end
    end
  end

  #show
  get '/teams/:team_id/players/:player_id' do
    redir_login_if_not_logged
    @player = Player.find(params[:player_id])
    if owner_or_teammate?(@player.team)
      erb :'/players/show'
    else
      redirect '/error/you-cant-view-this-player'
    end
  end

  #edit
  get '/teams/:team_id/players/:player_id/edit' do
    redir_login_if_not_logged
    @player = Player.find(params[:player_id])
    if owner?(@player.team)
      erb :'/players/edit'
    else
      redirect '/error/you-cant-do-that'
    end
  end

  #update
  patch '/teams/:team_id/players/:player_id' do
    redir_login_if_not_logged
    player = Player.find(params[:player_id])
    
    if !owner?(player.team)
      redirect '/error/you-cant-do-that'
    elsif !positions.include?(params[:position])
      redirect '/error/invalid-position'
    else
      player.update(name: params[:name], team: player.team, position: params[:position], jersey_num: params[:jersey], status: params[:active] ? "active" : "inactive")
      if player.errors.messages.empty?
        redirect "/teams/#{player.team.id}"
      else
        redirect '/error/something-went-wrong'
      end
    end

  end

  #delete
  delete '/teams/:team_id/players/:player_id' do
    redir_login_if_not_logged
    player = Player.find(params[:player_id])
    if owner?(player.team)
      player.destroy
      redirect "/teams/#{params[:team_id]}"
    else
      redirect '/error/you-cant-delete-that'
    end
  end

  get '/teams/:team_id/players/:player_id/codegen' do
    "TODO"
  end

end