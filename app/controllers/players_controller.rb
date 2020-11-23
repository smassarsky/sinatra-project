class PlayersController < ApplicationController

  #index
  get '/teams/:id/players' do
    redir_login_if_not_logged
    @team = Team.find(params[:id])
    if exists_and_owner_or_teammate?(@team)
      erb :'/players/index'
    end
  end

  #new
  get '/teams/:id/players/new' do
    redir_login_if_not_logged
    @team = Team.find(params[:id])
    if exists_and_owner?(@team)
      erb :'/players/new'
    end
  end

  #create
  post '/teams/:id/players' do
    redir_login_if_not_logged
    team = Team.find(params[:id])
    if exists_and_owner?(team)
      params[:player][:status] = params[:player][:status] ? "active" : "inactive"
      player = Player.create(params[:player])
      if player.id
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
    if exists_and_owner_or_teammate?(@player)
      erb :'/players/show'
    end
  end

  #edit
  get '/teams/:team_id/players/:player_id/edit' do
    redir_login_if_not_logged
    @player = Player.find(params[:player_id])
    if exists_and_owner?(@player)
      erb :'/players/edit'
    end
  end

  #update
  patch '/teams/:team_id/players/:player_id' do
    redir_login_if_not_logged
    player = Player.find(params[:player_id])
    if exists_and_owner?(player)
      params[:player][:status] = params[:player][:status] ? "active" : "inactive"
      player.update(params[:player])
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
    if exists_and_owner?(player)
      player.destroy
      redirect "/teams/#{params[:team_id]}"
    end
  end

  get '/teams/:team_id/players/:player_id/gen_user_code' do
    redir_login_if_not_logged
    @player = Player.find(params[:player_id])
    if exists_and_owner?(@player)
      @code = @player.player_code ? @player.player_code : PlayerCode.create(player: @player, code: SecureRandom.hex, status: "New")
      if @code.id
        erb :'/players/gen_code'
      else
        redirect '/error/error-generating-code'
      end
    end
  end

end