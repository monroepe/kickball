require 'sinatra'
require 'csv'
require 'pry'
 league = []
  CSV.foreach('lackp_starting_rosters.csv', headers: true,
    header_converters: :symbol) do |row|
    league << row.to_hash
  end

def get_teams(league)
  teams = []
  league.each do |team|
    teams << team[:team]
  end
  teams.uniq
end

def get_players(league)
  players = []
  league.each do |player|
    players << player[:first_name] + ' ' + player[:last_name]
  end
  players
end

def get_positions_by_player(league)
  player_positions = {}
  league.each do |player|
    player_positions[player[:first_name] + ' ' + player[:last_name]] = player[:position]
  end
  player_positions
end


get '/' do
  @league = league
  @players = get_players(league)
  @teams = get_teams(league)
  @player_positions = get_positions_by_player(league)
  erb :index
end

get '/:team_name' do
  @player_positions = get_positions_by_player(league)
  erb :team_name
end
