seth = User.find(1)

# create(username: "sethacct", first_name: "Seth", last_name: "Massarsky", email: "seth.massarsky@gmail.com", password: "1234")

mallards = Team.find_or_create_by(name: "Mallards", owner: seth)

winter2020 = Season.find_or_create_by(name: "Winter 2020", team: mallards)

mallards.current_season = winter2020
mallards.save

game1 = Game.find_or_create_by(season: winter2020, opponent: "someteam", status: "Complete", place: "Home", game_datetime: DateTime.parse("2020-11-10 17:00:00 -0500"))
game2 = Game.find_or_create_by(season: winter2020, opponent: "anotherteam", status: "Complete", place: "Away", game_datetime: DateTime.parse("2020-11-14 17:00:00 -0500"))
game3 = Game.find_or_create_by(season: winter2020, opponent: "athirdteam", status: "Complete", place: "Home", game_datetime: DateTime.parse("2020-11-16 17:00:00 -0500"))

game_to_be_played = Game.find_or_create_by(season: winter2020, opponent: "afourthteam", status: "TBP", place: "Away", game_datetime: DateTime.parse("2020-12-20 17:00:00 -0500"))
later_game_to_be_played = Game.find_or_create_by(season: winter2020, opponent: "afifthteam", status: "TBP", place: "Home", game_datetime: DateTime.parse("2020-12-21 17:00:00 -0500"))


seth_mallards = Player.find_or_create_by(name: "Seth", team: mallards, user: seth, position: "LW", jersey_num: 74, status: "active")

matt_mallards = Player.find_or_create_by(name: "Matt", team: mallards, position: "D", jersey_num: 54, status: "active")
lewin_mallards = Player.find_or_create_by(name:"Lewin", team: mallards, position: "RW", jersey_num: 76, status: "active")
thomas_mallards = Player.find_or_create_by(name: "Thomas", team: mallards, position: "RW", jersey_num: 88, status: "active")
fitz_mallards = Player.find_or_create_by(name: "Fitz", team: mallards, position: "C", jersey_num: 55, status: "active")

goal1 = Goal.find_or_create_by(game: game1, player: lewin_mallards, assist_players: [matt_mallards, thomas_mallards], team: mallards, period: 2, time_scored: "2:34")

penalty1 = Penalty.find_or_create_by(game: game1, player: seth_mallards, team: mallards, period: 2, time_committed: "2:34", length: 2, infraction: "slashing")