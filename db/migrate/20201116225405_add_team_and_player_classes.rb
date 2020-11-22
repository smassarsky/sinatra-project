class AddTeamAndPlayerClasses < ActiveRecord::Migration[6.0]
  def change

    create_table :teams do |t|
      t.string :name
      t.integer :owner_id
      t.integer :current_season_id
    end

    create_table :players do |t|
      t.string :name
      t.integer :team_id
      t.integer :user_id
      t.string :position
      t.integer :jersey_num
      t.string :status
    end

    create_table :seasons do |t|
      t.string :name
      t.integer :team_id
    end

    create_table :games do |t|
      t.integer :season_id
      t.string :opponent
      t.string :status
      t.string :win_loss
      t.string :place
      t.datetime :game_datetime
    end

    create_table :goals do |t|
      t.integer :game_id
      t.integer :player_id
      t.integer :team_id
      t.integer :period
      t.string :time_scored
    end

    create_table :penalties do |t|
      t.integer :game_id
      t.integer :player_id
      t.integer :team_id
      t.integer :period
      t.string :time_committed
      t.integer :length
      t.string :infraction
    end

    create_table :game_players do |t|
      t.integer :game_id
      t.integer :player_id
    end

    create_table :on_ice_for_goals do |t|
      t.integer :goal_id
      t.integer :player_id
    end

    create_table :assists do |t|
      t.integer :goal_id
      t.integer :player_id
    end

    create_table :player_codes do |t|
      t.integer :player_id
      t.string :code
      t.string :status
    end

  end
end
