class Game < ActiveRecord::Base
  belongs_to :season
  has_one :team, through: :season
  has_one :owner, through: :team
  has_many :game_players
  has_many :players, through: :game_players
  has_many :users, through: :players
  has_many :goals
  has_many :penalties

  def score

  end

  def game_of_season
    self.season.games.order(:game_datetime).find_index(self) + 1
  end

end