#!/usr/bin/ruby
require_relative 'dice'
require_relative 'player'
require_relative 'game'

module GameTurn
  def self.take_turn(player)
    hit=Dice.roll(6)
      case hit
        when 1..2
          d=Dice.roll(20)
          player.take_dmg(d)
          puts "#{player.pname} took #{d} (now:#{player.phealth})"
        when 3..4
          puts "#{player.pname} was was missed, health remains #{player.phealth}"
        else
          h=Dice.roll(20)
          player.heal(h)
          puts "#{player.pname} was healed #{h} (now:#{player.phealth})"
      end
      treasure=TreasureTrove.random
      player.found_treasure(treasure)
  end
end

if __FILE__ == $0
  myGame = Game.new("knuckleheads")
  take_turn(myGame.players.first)
end
