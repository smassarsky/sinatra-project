class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  has_one :owner, through: :team
  has_many :seasons, through: :team
  has_one :current_season, through: :team
  has_many :games, through: :seasons
  has_many :goals
  has_many :assists
  has_many :goal_assist, through: :assists, source: "goal"
  has_many :penalties
  has_many :game_players
  has_many :games_played, through: :game_players, source: "game"
  has_many :on_ice_for_goals
  has_many :plus_minuses, through: :on_ice_for_goals, source: "goals"
  has_one :player_code

  validates :name, presence: true
  validates :team_id, presence: true
  validates :status, presence: true

  
  def count_goals(thing)
    thing.goals.where(player: self).count
  end

  def count_assists(thing)
    thing.assists.where(player: self).count
  end

  def points(thing)
    count_goals(thing) + count_assists(thing)
  end

  def plus_minus(thing)
    all_goals = thing.on_ice_for_goals.where(player: self)
    all_goals.count{|on_ice| on_ice.goal.team != nil} - all_goals.count{|on_ice| on_ice.goal.team == nil}
  end

  def pim(thing)
    "#{thing.penalties.where(player: self).sum(:length)}:00"
  end

  def games_played_in(thing)
    self.game_players.where(player: self).count
  end

  def stats(thing)
    stats_hash = {}
    stats_hash[:goals] = count_goals(thing)
    stats_hash[:assists] = count_assists(thing)
    stats_hash[:points] = stats_hash[:goals] + stats_hash[:assists]
    stats_hash[:plus_minus] = plus_minus(thing)
    stats_hash[:pim] = pim(thing)
    stats_hash[:games_played] = games_played_in(thing)
    stats_hash
  end

  def all_seasons_stats
    all_stats = {totals: {}}
    self.seasons.each do |season|
      temp = stats(season)
      all_stats[season.name] = temp
      all_stats[:totals] = temp.merge(all_stats[:totals])
    end
    all_stats
  end

end