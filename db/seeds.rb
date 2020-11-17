seth = User.find(1)

# create(username: "sethacct", first_name: "Seth", last_name: "Massarsky", email: "seth.massarsky@gmail.com", password: "1234")

mallards = Team.find_or_create_by(name: "Mallards", owner: seth)

winter2020 = Season.find_or_create_by(name: "Winter 2020", team: mallards)

game1 = Game.find_or_create_by(season: winter2020, opponent: "someteam", status: "Win", home: true, game_datetime: Time.now)

seth_mallards = Player.find_or_create_by(name: "Seth", team: mallards, user: seth, active: true)

goal1 = Goal.find_or_create_by(game: game1, player: seth_mallards, team: mallards, period: 2, time_scored: "2:34")

penalty1 = Penalty.find_or_create_by(game: game1, player: seth_mallards, team: mallards, period: 2, time_committed: "2:34", length: 2, infraction: "slashing")