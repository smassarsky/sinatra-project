class GamesController < ApplicationController

  #index
  get '/teams/:team_id/seasons/:season_id/games' do
    "TODO - index"
  end

  #new
  get '/teams/:team_id/seasons/:season_id/games/new' do
    "TODO - new"
  end

  #create
  post '/teams/:team_id/seasons/:season_id/games' do
    "TODO - create"
  end

  #show
  get '/teams/:team_id/seasons/:season_id/games/:game_id' do
    "TODO - show"
  end

  #edit
  get '/teams/:team_id/seasons/:season_id/games/:game_id/edit' do
    "TODO - edit"
  end

  #update
  patch '/teams/:team_id/seasons/:season_id/games/:game_id' do
    "TODO - update"
  end

  #delete
  delete '/teams/:team_id/seasons/:season_id/games/:game_id' do
    "TODO - delete"
  end

end