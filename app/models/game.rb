class Game < ActiveRecord::Base
  belongs_to :season
  has_one :team, through: :season
  has_many :game_players
  has_many :players, through: :game_players
  has_many :users, through: :players
  has_many :goals
  has_many :penalties

  def score

  end

end