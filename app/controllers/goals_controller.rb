class GoalsController < ApplicationController

  #new
  get '/teams/:team_id/seasons/:season_id/games/:game_id/goals/new' do
    redir_login_if_not_logged
    @game = Game.find(params[:game_id])
    if exists_and_owner?(@game)
      erb :'/goals/new'
    end
  end

  #create
  post "/teams/:team_id/seasons/:season_id/games/:game_id/goals" do
    redir_login_if_not_logged
    game = Game.find(params[:game_id])
    if exists_and_owner?(game)
      params[:goal][:time_scored] = "#{params[:time_minutes]}:#{params[:time_seconds]}"
      goal = Goal.create(params[:goal])
      if goal.id
        redirect "/teams/#{params[:team_id]}/seasons/#{params[:season_id]}/games/#{params[:game_id]}"
      else
        redirect '/error/error-creating-goal'
      end
    end
  end

  #edit
  get '/teams/:team_id/seasons/:season_id/games/:game_id/goals/:goal_id/edit' do
    redir_login_if_not_logged
    @goal = Goal.find(params[:goal_id])
    if exists_and_owner?(@goal)
      erb :'/goals/edit'
    end
  end

  #update
  patch '/teams/:team_id/seasons/:season_id/games/:game_id/goals/:goal_id' do
    redir_login_if_not_logged
    goal = Goal.find(params[:goal_id])
    if exists_and_owner?(goal)
      params[:goal][:time_scored] = "#{params[:time_minutes]}:#{params[:time_seconds]}"
      goal.update(params[:goal])
      redirect "/teams/#{params[:team_id]}/seasons/#{params[:season_id]}/games/#{params[:game_id]}"
    end
  end

  #delete
  delete '/teams/:team_id/seasons/:season_id/games/:game_id/goals/:goal_id' do
    redir_login_if_not_logged
    goal = Goal.find(params[:goal_id])
    if exists_and_owner?(goal)
      goal.destroy
      redirect "/teams/#{params[:team_id]}/seasons/#{params[:season_id]}/games/#{params[:game_id]}"
    end
  end

end