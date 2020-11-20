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
    scorer = Player.find(params[:player_id])
    assist_1 = Player.find(params[:assist_1_id])
    assist_2 = Player.find(params[:assist_2_id])
    if game && owner?(game)
      goal = Goal.new(game: game, player: scorer, assist_1: assist_1, assist_2: assist_2, team: params[:team] == "us" ? game.team : nil, period: params[:period], time_scored: "#{params[:time_minutes]}:#{params[:time_seconds]}")
      redirect '/'
    elsif game
      redirect '/error/you-cant-edit-that'
    else
      redirect '/error/invalid-game'
    end
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