#!/usr/bin/ruby
require_relative 'game'
require_relative 'game_setup'
require_relative 'player'
require_relative 'database'

knuckleheads =Game.new("knuckleheads")

loop do
  system("clear")
  puts '1. Play Game'
  puts '2. Create Database'
  puts '3. Add Player'
  puts '4. Add Treasure'
  puts '5. Exit'
  print "\nWhat would you like to do : "
  menu = gets.to_i

  case menu
    when 1
      print 'How many games would you like to play: '
      response=gets.strip.to_i
      knuckleheads.play(response.to_i)
      print "\n press enter to continue..."
      gets
      loop
    when 2
      Database.create
      print "\n press enter to continue..."
      gets
      loop
    when 3
      puts 'Add a new player'
      print 'Name:'
      st_n=gets.chomp.downcase
      print 'Health:'
      st_h=gets.chomp.downcase
      player=Player.new(st_n, st_h.to_i)
      Database.add_player(player)
      loop
    when 4
     puts 'Add a new treasure'
      print 'Treasure Name:'
      st_n=gets.chomp.downcase
      print 'Treasure Points:'
      st_points=gets.chomp.downcase
      treasure=Treasure.new(st_n, st_points.to_i)
      Database.add_treasure(treasure)
      loop
    when 5
      knuckleheads.print_stats if ! knuckleheads.nil?
      break
    else
      loop
  end
end

knuckleheads.print_high_score

