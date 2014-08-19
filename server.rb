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

def get_players_by_team(league, team)
  league.find_all do |player|
    player[:team] == team
  end
end




get '/' do
  @league = league
  @teams = get_teams(league)
  erb :index
end

get '/:team_name' do
  @league = league
  @player_positions = get_players_by_team(league, params[:team_name])
  erb :team_name
end
