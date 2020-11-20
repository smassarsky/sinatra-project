class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  has_one :owner, through: :team
  has_many :seasons, through: :team
  has_many :games, through: :seasons
  has_many :goals
  has_many :assists
  has_many :goal_assist, through: :assists, source: "goal"
  has_many :penalties
  has_many :game_players
  has_many :games_played, through: :game_players, source: "game"

  validates :name, presence: true
  validates :team_id, presence: true
  validates :status, presence: true

  
  def count_goals(thing)
    thing.goals.where(player: self).count
  end

  def count_assists(thing)
    thing.assists.where(player:self).count
  end

end