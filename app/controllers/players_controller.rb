class PlayersController < ApplicationController

  get '/teams/:id/players' do
    "TODO"
  end

  get '/teams/:id/players/new' do
    redir_login_if_not_logged
    @team = Team.find(params[:id])
    @positions = ["C", "LW", "RW", "D", "G"]
    if current_user == @team.owner
      erb :'/players/new'
    else
      redirect '/error/you-cant-do-that'
    end
  end

  post '/teams/:id/players' do
    puts params
    redir_login_if_not_logged
    team = Team.find(params[:id])
    positions = ["C", "LW", "RW", "D", "G"]
    if current_user != team.owner
      redirect '/error/you-cant-do-that'
    elsif !positions.include?(params[:position])
      redirect '/error/invalid-position'
    else
      player = Player.create(name: params[:name], team: team, position: params[:position], jersey_num: params[:jersey], status: params[:active] ? "Active" : "Inactive")
      binding.pry
      if player.errors.messages.empty?
        redirect "/teams/#{params[:id]}/players/#{player.id}"
      else
        redirect '/error/something-went-wrong'
      end
    end
  end

end