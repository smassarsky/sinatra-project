class Team < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  has_many :players
  has_many :users, through: :players, foreign_key: "user_id"
  has_many :seasons
  has_many :games, through: :seasons
  has_many :goals, through: :games
  has_many :penalties, through: :games
  belongs_to :current_season, class_name: "Season"

  validates :owner, presence: true
  validates :name, presence: true

  def record
    if self.current_season
      self.current_season.record_parsed
    else
      "-"
    end
  end

  def next_game
    if !self.current_season
      "-"
    else
      self.current_season.next_game
    end
  end

  def full_roster
    {
      active: self.players.where(status: "active"),
      inactive: self.players.where(status: "inactive")
    }
  end

  def active_players
    self.players.where(status: "active")
  end

  def inactive_players
    self.players.where(status: "inactive")
  end

end