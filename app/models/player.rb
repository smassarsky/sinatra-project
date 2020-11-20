class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  has_one :owner, through: :team
  has_many :seasons, through: :team
  has_many :games, through: :seasons
  has_many :goals
  has_many :assist_1s, class_name: "Goal", foreign_key: "assist_1"
  has_many :assist_2s, class_name: "Goal", foreign_key: "assist_2"
  has_many :penalties
  has_many :game_players
  has_many :games_played, through: :game_players, source: "game"

  validates :name, presence: true
  validates :team_id, presence: true
  validates :status, presence: true
end