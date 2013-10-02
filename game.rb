#!/usr/bin/ruby
require_relative 'player'
require_relative 'game_turn'
require_relative 'game_setup'

class Game
  attr_reader :title, :players

  def initialize(title)
    @title=title
    @players=GameSetup.game_players
  end

  def print_stats
    system("clear")
    strong, wimpy = @players.partition { |p| p.strong? }
    puts "#{@title} Statistics:\n"
    puts "#{strong.size} Strong Players:\n"
    strong.each { |p| puts "#{p.pname} (#{p.phealth})\n" }
    puts "\n#{wimpy.count} Wimpy Playes\n"
    wimpy.each { |p| puts "#{p.pname} (#{p.phealth})\n" }

    @players.sort.each do |player|
      puts "\n#{player.pname}'s point totals:"
      player.each_found_treasure do |treasure|
        puts "#{treasure.points} total #{treasure.name} points"
      end
      puts "#{player.points} grand total points"
    end
  end

  def print_high_score
    puts "\n#{@title} High Scores:\n"
    sorted_players = @players.sort
    sorted_players.each do |player|
      formatted_name = player.pname.ljust(20,'.')
      puts "#{formatted_name} #{player.score}"
    end
  end

  def play(turns)
    1.upto(turns) do |round|
      puts "\nRound #{round}"
      @players.each do |p|
        GameTurn.take_turn(p)
      end
    end
  end
end

  if __FILE__ == $0
    myGame=Game.new("sean")

    puts myGame.players.class
    puts myGame.treasures.class
    myGame.players.each { |p1| puts "#{ p1.pname }" }

  end
