class SeasonsController < ApplicationController

  #index
  get '/teams/:team_id/seasons' do
    redir_login_if_not_logged
    @team = Team.find(params[:team_id])
    if exists_and_owner_or_teammate?(@team)
      erb :'/seasons/index'
    end
  end

  #new
  get '/teams/:team_id/seasons/new' do
    redir_login_if_not_logged
    @team = Team.find(params[:team_id])
    if exists_and_owner?(@team)
      erb :'/seasons/new'
    end
  end

  #create
  post '/teams/:team_id/seasons' do
    redir_login_if_not_logged
    team = Team.find(params[:team_id])
    if exists_and_owner?(team)
      season = Season.create(name: params[:season_name], team: team)
      if season.id
        if params[:current_season]
          team.update(current_season: season)
        end
        redirect "/teams/#{team.id}/seasons/#{season.id}"
      else
        redirect '/error/something-went-wrong'
      end
    end
  end

  #show
  get '/teams/:team_id/seasons/:season_id' do
    redir_login_if_not_logged
    @season = Season.find(params[:season_id])
    if exists_and_owner_or_teammate?(@season)
      erb :'/seasons/show'
    end
  end

  #edit
  get '/teams/:team_id/seasons/:season_id/edit' do
    redir_login_if_not_logged
    @season = Season.find(params[:season_id])
    if exists_and_owner?(@season)
      erb :'/seasons/edit'
    end
  end

  #update
  patch '/teams/:team_id/seasons/:season_id' do
    redir_login_if_not_logged
    season = Season.find(params[:season_id])
    if exists_and_owner?(season)
      season.update(name: params[:season_name])
      if params[:current_season]
        season.team.update(current_season: season)
      elsif season.team.current_season == season
        season.team.update(current_season: nil)
      end
      redirect "/teams/#{season.team.id}/seasons/#{season.id}"
    end
  end

  #delete
  delete '/teams/:team_id/seasons/:season_id' do
    redir_login_if_not_logged
    season = Season.find(params[:season_id])
    if exists_and_owner?(season)
      season.games.destroy_all
      season.destroy
      redirect "/teams/#{params[:team_id]}/seasons"
    end
  end
end