require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect '/dashboard' if is_logged_in?
    erb :index
  end

  helpers do

    def current_user
      @user ||= User.find(session[:user_id])
    end

    def is_logged_in?
      !!session[:user_id]
    end

    def redir_login_if_not_logged
      redirect '/login' if !is_logged_in?
    end

    def redir_dash_if_logged
      redirect '/dashboard' if is_logged_in?
    end

    def positions
      ["C", "LW", "RW", "D", "G"]
    end

    def owner_or_teammate?(team)
      current_user == team.owner || team.users.include?(current_user)
    end

    def owner?(team)
      current_user == team.owner
    end

    def current_season?(season)
      season == season.team.current_season
    end

    def game_statuses
      ["TBP", "Complete"]
    end

    def home_away_options
      ["Home", "Away"]
    end

    def parse_record(record)
      "#{record["Win"] ||= 0} - #{record["Loss"] ||= 0} - #{record["OTL"] ||= 0}"
    end

    def periods
      ["1st", "2nd", "3rd", "OT1", "OT2", "OT3", "OT4", "S/O"]
    end

  end

end