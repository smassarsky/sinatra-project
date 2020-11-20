class Goal < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  has_one :user, through: :player
  belongs_to :assist_1, class_name: "Player"
  belongs_to :assist_2, class_name: "Player"
  belongs_to :team

  validates :game_id, presence: true
  validates :player_id, presence: true
  validates :team_id, presence: true
end