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

  end

  get '/games/:game_id/goals/:goal_id' do
    redir_login_if_not_logged

  end

  patch '/games/:game_id/goals/:goal_id' do
    redir_login_if_not_logged

  end

  delete '/games/:game_id/goals/:goal_id' do
    redir_login_if_not_logged

  end

end