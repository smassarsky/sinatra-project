class Team < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  has_many :players
  has_many :users, through: :players, foreign_key: "user_id"
  has_many :seasons
  has_many :games, through: :seasons
  has_many :goals, through: :games
  has_many :penalties, through: :games

  validates :owner, presence: true
  validates :name, presence: true

end