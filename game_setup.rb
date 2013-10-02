#!/usr/bin/ruby
require_relative 'player'
require_relative 'database'
require_relative 'treasure_trove'

class GameSetup

  attr_reader :gplayers, :gtreasures

  def initialize(game='knuckleheads')
      @game = game
      @gplayers=game_players
      @gtreasures = game_treasures
  end

  def GameSetup.game_players
    players=[]
    rs=Database.get_players
    rs.each do |p|
      players << Player.new(p[0], p[1])
    end
    return players
  end

  def GameSetup.game_treasures
    treasures=[]
    rs=Database.get_treasures
    rs.each do |t|
      treasures << Treasure.new(t[0], t[1])
    end
    return treasures
  end
end

if __FILE__ == $0
  require_relative 'game_setup'
  @players=GameSetup.game_players
  @treasures=GameSetup.game_treasures
  puts @treasures.class

  @players.each { |p1| puts "#{ p1.pname }" }
  @treasures.each { |t1| puts "#{ t1.name}" }
end
