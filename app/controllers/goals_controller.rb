class GoalsController < ApplicationController

  get '/games/:game_id/goals/new' do
    redir_login_if_not_logged
    @game = Game.find(params[:game_id])
    if @game and owner?(@game)
      erb :'/goals/new'
    elsif @game
      redirect '/error/you-cant-do-that'
    else
      redirect '/error/game-not-found'
    end
  end

  post "/games/:game_id/goals" do
    redir_login_if_not_logged
    game = Game.find(params[:game_id])
    if game && owner?(game)
      params[:goal][:time_scored] = "#{params[:time_minutes]}:#{params[:time_seconds]}"
      goal = Goal.create(params[:goal])
      if goal.id
        redirect "/teams/#{game.team.id}/seasons/#{game.season.id}/games/#{game.id}"
      else
        redirect '/error/error-creating-goal'
      end
    elsif game
      redirect '/error/you-cant-edit-that'
    else
      redirect '/error/invalid-game'
    end
  end

  get '/games/:game_id/goals/:goal_id/edit' do
    redir_login_if_not_logged
    @goal = Goal.find(params[:goal_id])
    if @goal && owner?(@goal)
      erb :'/goals/edit'
    elsif @goal
      redirect '/error/you-cant-edit-that'
    else
      redirect '/error/invalid-goal'
    end
  end

  patch '/games/:game_id/goals/:goal_id' do
    redir_login_if_not_logged
    goal = Goal.find(params[:goal_id])
    if goal && owner?(goal)
      params[:goal][:time_scored] = "#{params[:time_minutes]}:#{params[:time_seconds]}"
      goal.update(params[:goal])
      redirect "/teams/#{goal.game.team.id}/seasons/#{goal.season.id}/games/#{goal.id}"
    elsif game
      redirect '/error/you-cant-edit-that'
    else
      redirect '/error/invalid-game'
    end
  end

  delete '/games/:game_id/goals/:goal_id' do
    redir_login_if_not_logged
    goal = Goal.find(params[:goal_id])
    if goal && owner?(goal)
      goal.destroy
      redirect "/games/#{params[:game_id]}"
    elsif goal
      redirect '/error/you-cant-edit-that'
    else
      redirect '/error/invalid-goal'
    end
  end

end