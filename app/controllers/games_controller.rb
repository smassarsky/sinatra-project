class GamesController < ApplicationController

  #index
  # get '/teams/:team_id/seasons/:season_id/games' do
  #   "TODO - index (don't really need this route because of /teams/:team_id/seasons/:season_id"
  # end

  #new
  get '/teams/:team_id/seasons/:season_id/games/new' do
    redir_login_if_not_logged
    @season = Season.find(params[:season_id])
    if exists_and_owner?(@season)
      erb :'/games/new'
    end
  end

  #create
  post '/teams/:team_id/seasons/:season_id/games' do
    redir_login_if_not_logged
    season = Season.find(params[:season_id])
    if exists_and_owner?(season)
      params[:game][:season_id] = params[:season_id]
      game = Game.create(params[:game])
      if game.id
        redirect "/teams/#{params[:team_id]}/seasons/#{params[:season_id]}/games/#{game.id}"
      else
        redirect '/error/error-creating-game'
      end
    end
  end

  #show
  get '/teams/:team_id/seasons/:season_id/games/:game_id' do
    redir_login_if_not_logged
    @game = Game.find(params[:game_id])
    if exists_and_owner_or_teammate?(@game)
      erb :'/games/show'
    end
  end

  #edit
  get '/teams/:team_id/seasons/:season_id/games/:game_id/edit' do
    redir_login_if_not_logged
    @game = Game.find(params[:game_id])
    if exists_and_owner?(@game)
      erb :'/games/edit'
    end
  end

  #update
  patch '/teams/:team_id/seasons/:season_id/games/:game_id' do
    redir_login_if_not_logged
    game = Game.find(params[:game_id])
    if exists_and_owner?(game)
      game.update(params[:game])
      redirect "/teams/#{params[:team_id]}/seasons/#{params[:season_id]}/games/#{params[:game_id]}"
    end
  end

  #delete
  delete '/teams/:team_id/seasons/:season_id/games/:game_id' do
    redir_login_if_not_logged
    game = Game.find(params[:game_id])
    if exists_and_owner?(game)
      game.destroy
      redirect "/teams/#{params[:team_id]}/seasons/#{params[:season_id]}"
    end
  end

  #form to add players to game
  get '/teams/:team_id/seasons/:season_id/games/:game_id/players' do
    redir_login_if_not_logged
    @game = Game.find(params[:game_id])
    if exists_and_owner?(@game)
      erb :'/games/gameplayers'
    end
  end

  #post to add / modify players in game
  post '/teams/:team_id/seasons/:season_id/games/:game_id/players' do
    redir_login_if_not_logged
    game = Game.find(params[:game_id])
    if exists_and_owner?(game)
      game.update(attending_players: Player.find(params[:attending_player_ids]).select{|player| owner?(player)})
      redirect "/teams/#{game.team.id}/seasons/#{game.season.id}/games/#{game.id}"
    end
  end

end