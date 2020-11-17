class Penalty < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  has_one :user, through: :player
  belongs_to :team

  validates :game_id, presence: true
  validates :player_id, presence: true
  validates :team_id, presence: true
  validates :length, presence: true
end