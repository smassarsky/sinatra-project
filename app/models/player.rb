class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  has_many :seasons, through: :team
  has_many :games, through: :seasons
  has_many :goals
  has_many :penalties
  has_many :game_players
  has_many :games_played, through: :game_players, source: "game"

  validates :name, presence: true
  validates :team_id, presence: true
  validates :active, presence: true
end