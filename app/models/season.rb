class Season < ActiveRecord::Base
  belongs_to :team
  has_many :players, through: :team
  has_many :games
  has_many :goals, through: :games
  has_many :penalties, through: :games

  validates :name, presence: true
  validates :team_id, presence: true

  def record
    count = self.games.group(:status).count
    "#{count["Win"] ||= 0} - #{count["Loss"] ||= 0} - #{count["OTL"] ||= 0}"
  end

  def current_season?
    self.team.current_season == self
  end

  def next_game
    self.games.where('game_datetime > ?', DateTime.now).min{|a, b| a.game_datetime <=> b.game_datetime}
  end

end