class PenaltiesController < ApplicationController

  #new
  get '/teams/:team_id/seasons/:season_id/games/:game_id/penalties/new' do
    redir_login_if_not_logged
    @game = Game.find(params[:game_id])
    if exists_and_owner?(@game)
      erb :'/penalties/new'
    end
  end

  #create
  post "/teams/:team_id/seasons/:season_id/games/:game_id/penalties" do
    redir_login_if_not_logged
    game = Game.find(params[:game_id])
    if exists_and_owner?(game)
      params[:penalty][:time_committed] = "#{params[:time_minutes]}:#{params[:time_seconds]}"
      penalty = Penalty.create(params[:penalty])
      if penalty.id
        redirect "/teams/#{game.team.id}/seasons/#{game.season.id}/games/#{game.id}"
      else
        redirect '/error/error-creating-penalty'
      end
    end
  end

  #edit
  get '/teams/:team_id/seasons/:season_id/games/:game_id/penalties/:penalty_id/edit' do
    redir_login_if_not_logged
    @penalty = Penalty.find(params[:penalty_id])
    if exists_and_owner?(@penalty)
      erb :'/penalties/edit'
    end
  end

  #update
  patch '/teams/:team_id/seasons/:season_id/games/:game_id/penalties/:penalty_id' do
    redir_login_if_not_logged
    penalty = Penalty.find(params[:penalty_id])
    if exists_and_owner?(penalty)
      params[:penalty][:time_committed] = "#{params[:time_minutes]}:#{params[:time_seconds]}"
      penalty.update(params[:penalty])
      redirect "/teams/#{penalty.game.team.id}/seasons/#{penalty.season.id}/games/#{penalty.game.id}"
    end
  end

  #delete
  delete '/teams/:team_id/seasons/:season_id/games/:game_id/penalties/:penalty_id' do
    redir_login_if_not_logged
    penalty = Penalty.find(params[:penalty_id])
    if exists_and_owner?(penalty)
      penalty.destroy
      redirect "/teams/#{params[:team_id]}/seasons/#{params[:season_id]}/games/#{params[:game_id]}"
    end
  end

end