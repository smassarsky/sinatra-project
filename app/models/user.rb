class User < ActiveRecord::Base
  has_secure_password
  has_many :teams_owned, class_name: "Team", foreign_key: "owner_id"
  has_many :players
  has_many :teams_played_for, through: :players, source: "team"
  has_many :goals, through: :players
  has_many :penalties, through: :players
  has_many :seasons, through: :teams_played_for
  has_many :games, through: :seasons
  has_many :games_played, through: :players


  validates :username, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  def upcoming_games
    self.games.where(status: "TBP").order(:game_datetime).limit(5)
  end

end
