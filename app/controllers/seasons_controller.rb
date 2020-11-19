class SeasonsController < ApplicationController

  #index
  get '/teams/:team_id/seasons' do
    redir_login_if_not_logged
    @team = Team.find(params[:team_id])
    if @team && owner_or_teammate?(@team)
      erb :'/seasons/index'
    elsif @team
      redirect '/error/you-cant-view-that'
    else
      redirect '/error/invalid-team'
    end
  end

  #new
  get '/teams/:team_id/seasons/new' do
    redir_login_if_not_logged
    @team = Team.find(params[:team_id])
    if owner?(@team)
      erb :'/seasons/new'
    else
      redirect '/error/you-cant-do-that'
    end
  end

  #create
  post '/teams/:team_id/seasons' do
    redir_login_if_not_logged
    team = Team.find(params[:team_id])
    if owner?(team)
      season = Season.create(name: params[:season_name], team: team)
      if season.id
        if params[:current_season]
          team.update(current_season: season)
        end
        redirect "/teams/#{team.id}/seasons/#{season.id}"
      else
        redirect '/error/something-went-wrong'
      end
    else
      redirect '/error/you-cant-do-that'
    end
  end

  #show
  get '/teams/:team_id/seasons/:season_id' do
    redir_login_if_not_logged
    @season = Season.find(params[:season_id])
    if @season && owner_or_teammate?(@season.team)
      erb :'/seasons/show'
    elsif @season
      redirect '/error/you-cant-view-this-season'
    else
      redirect '/error/invalid-season'
    end
  end

  #edit
  get '/teams/:team_id/seasons/:season_id/edit' do
    redir_login_if_not_logged
    @season = Season.find(params[:season_id])
    if @season && owner?(@season.team)
      erb :'/seasons/edit'
    elsif @season
      redirect '/error/you-cant-edit-that'
    else
      redirect '/error/invalid-season'
    end
  end

  #update
  patch '/teams/:team_id/seasons/:season_id' do
    redir_login_if_not_logged
    season = Season.find(params[:season_id])
    if season && owner?(season.team)
      season.update(name: params[:season_name])
      if params[:current_season]
        season.team.update(current_season: season)
      elsif season.team.current_season == season
        season.team.update(current_season: nil)
      end
      redirect "/teams/#{season.team.id}/seasons/#{season.id}"
    else
      redirect '/error/you-cant-do-that'
    end
  end

  #delete
  delete '/teams/:team_id/seasons/:season_id' do
    redir_login_if_not_logged
    season = Season.find(params[:season_id])
    if season && owner?(season.team)
      season.games.destroy_all
      season.destroy
      redirect "/teams/#{params[:team_id]}/seasons"
    elsif season
      redirect '/error/you-cant-do-that'
    else
      redirect '/error/invalid-season'
    end
  end
end