class Season < ActiveRecord::Base
  belongs_to :team
  has_many :players, through: :team
  has_many :games
  has_many :goals, through: :games
  has_many :penalties, through: :games

  validates :name, presence: true
  validates :team_id, presence: true
end