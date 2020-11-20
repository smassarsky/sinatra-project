class Game < ActiveRecord::Base
  belongs_to :season
  has_one :team, through: :season
  has_one :owner, through: :team
  has_many :game_players
  has_many :players, through: :game_players
  has_many :users, through: :players
  has_many :goals
  has_many :assists, through: :goals
  has_many :assist_players, through: :goals
  has_many :penalties

  def save
    self.win_loss = self.status == "TBP" ? "TBD" : won_lost
    super
  end

  def update(args)
    self.win_loss = self.status == "TBP" ? "TBD" : won_lost
    super
  end

  def won_lost
    score_hash = score
    if score_hash[:us] > score_hash[:them]
      "Win"
    elsif score_hash[:us] == score_hash[:them]
      "Tie"
    elsif self.goals.map{|goal| goal.period}.find{|x| x > 3}
      "OTL"
    else
      "Loss"
    end
  end

  def score
    {us: self.goals.where(team: self.team).count, them: self.goals.where(team_id: 0).count}
  end

  def score_formatted
    score_hash = score
    "#{score_hash[:us]} - #{score_hash[:them]}"
  end

  def game_of_season
    self.season.games.order(:game_datetime).find_index(self) + 1
  end

end