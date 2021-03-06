class Season < ActiveRecord::Base
  belongs_to :team
  has_many :players, through: :team
  has_many :users, through: :players
  has_one :owner, through: :team
  has_many :games
  has_many :game_players, through: :games
  has_many :goals, through: :games
  has_many :assists, through: :goals
  has_many :assist_players, through: :goals
  has_many :on_ice_for_goals, through: :goals
  has_many :on_ice_for_goal_players, through: :on_ice_for_goals
  has_many :penalties, through: :games

  validates :name, presence: true
  validates :team_id, presence: true

  def record
    self.games.group(:win_loss).count
  end

  def record_parsed
    count = self.record
    "#{count["Win"] ||= 0} - #{count["Loss"] ||= 0} - #{count["Tie"] ||= 0} - #{count["OTL"] ||= 0}"
  end

  def current_season?
    self.team.current_season == self
  end

  def next_game
    games = self.games.where('game_datetime > ?', DateTime.now)
    if games.empty?
      "None Scheduled"
    else
      selection = games.min{|a, b| a.game_datetime <=> b.game_datetime}
      "#{selection.game_datetime} #{selection.place == "Away" ? 'at' : 'vs'} #{selection.opponent}"
    end
  end

  def next_game_obj
    games = self.games.where('game_datetime > ?', DateTime.now)
    if games.empty?
      nil
    else
      games.min{|a, b| a.game_datetime <=> b.game_datetime}
    end
  end

end