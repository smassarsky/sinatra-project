class PenaltiesController < ApplicationController

  get '/games/:game_id/penalties/new' do
    redir_login_if_not_logged
    @game = Game.find(params[:game_id])
    if @game and owner?(@game)
      erb :'/penalties/new'
    elsif @game
      redirect '/error/you-cant-do-that'
    else
      redirect '/error/game-not-found'
    end
  end

  post "/games/:game_id/penalties" do
    redir_login_if_not_logged

  end

  get '/games/:game_id/penalties/:penalty_id' do
    redir_login_if_not_logged

  end

  patch '/games/:game_id/penalties/:penalty_id' do
    redir_login_if_not_logged

  end

  delete '/games/:game_id/penalties/:penalty_id' do
    redir_login_if_not_logged

  end

end