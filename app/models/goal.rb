class Goal < ActiveRecord::Base
  belongs_to :game
  has_one :owner, through: :game
  has_one :season, through: :game
  belongs_to :player
  has_one :user, through: :player
  has_many :assists
  has_many :assist_players, through: :assists, source: "player"
  belongs_to :team

  validates :game_id, presence: true

  def save
    super
    self.game.save
  end

end