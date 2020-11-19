class GamesController < ApplicationController

  #index
  get '/teams/:team_id/seasons/:season_id/games' do
    "TODO - index (don't really need this route because of /teams/:team_id/seasons/:season_id"
  end

  #new
  get '/teams/:team_id/seasons/:season_id/games/new' do
    redir_login_if_not_logged
    @season = Season.find(params[:season_id])
    if @season && owner?(@season)
      erb :'/games/new'
    elsif @season
      redirect '/error/you-cant-edit-this'
    else
      redirect '/error/invalid-season'
    end
  end

  #create
  post '/teams/:team_id/seasons/:season_id/games' do
    redir_login_if_not_logged
    season = Season.find(params[:season_id])
    if season && owner?(season)
      game = Game.create(season: season, opponent: params[:opponent], place: params[:at], status: params[:status], game_datetime: DateTime.parse(params[:datetime]))
      if game.id
        redirect "/teams/#{params[:team_id]}/seasons/#{params[:season_id]}/games/#{game.id}"
      else
        redirect '/error/error-creating-team'
      end
    elsif season
      redirect '/error/you-cannot-edit-this-season'
    else
      redirect '/error/invalid-season'
    end
  end

  #show
  get '/teams/:team_id/seasons/:season_id/games/:game_id' do
    redir_login_if_not_logged
    @game = Game.find(params[:game_id])
    if @game && owner_or_teammate?(@game.team)
      erb :'/games/show'
    elsif @game
      redirect '/error/you-cant-view-that'
    else
      redirect '/error/invalid-game-id'
    end
  end

  #edit
  get '/teams/:team_id/seasons/:season_id/games/:game_id/edit' do
    redir_login_if_not_logged
    @game = Game.find(params[:game_id])
    if @game && owner?(@game)
      erb :'/games/edit'
    elsif @game
      redirect '/error/you-cant-edit-this'
    else
      redirect '/error/invalid-season'
    end
  end

  #update
  patch '/teams/:team_id/seasons/:season_id/games/:game_id' do
    redir_login_if_not_logged
    game = Game.find(params[:game_id])
    if game && owner?(game)
      game.update(opponent: params[:opponent], place: params[:at], status: params[:status], game_datetime: DateTime.parse(params[:datetime]))
      redirect "/teams/#{params[:team_id]}/seasons/#{params[:season_id]}/games/#{params[:game_id]}"
    elsif game
      redirect '/error/you-cant-edit-this'
    else
      redirect '/error/invalid-game'
    end
  end

  #delete
  delete '/teams/:team_id/seasons/:season_id/games/:game_id' do
    redir_login_if_not_logged
    game = Game.find(params[:game_id])
    if game && owner?(game)
      game.destroy
      redirect "/teams/#{params[:team_id]}/seasons/#{params[:season_id]}"
    elsif game
      redirect '/error/you-cant-edit-this'
    else
      redirect '/error/invalid-game'
    end
  end

end