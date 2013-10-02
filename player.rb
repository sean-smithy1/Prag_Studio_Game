#!/usr/bin/ruby
require_relative 'treasure_trove'
require_relative 'database'

class Player
  attr_reader :phealth
  attr_accessor :pname

  def initialize(pname, phealth=100)
      @pname=pname.capitalize
      @phealth=phealth
      @found_treasures = Hash.new(0)
  end

  def found_treasure(treasure)
    @found_treasures[treasure.name] += treasure.points
    puts "#{@pname} found a #{treasure.name} worth #{treasure.points}."
    puts @found_treasures
  end

  def points
    @found_treasures.values.reduce(0, :+)
  end

  def score
    @phealth + points
  end

  def greet
    puts "I'm #{@pname} with a health of #{@phealth} and a score of #{score} as of #{as_at}"
  end

  def take_dmg(dmg)
    @phealth -= dmg
  end

  def heal(health)
    @phealth += health
  end

  def to_s
    "I'm #{@pname} with health = #{@phealth}, points = #{points}, and score = #{score}."
  end

  def <=> (other)
    other.score <=> score
  end


  def strong?
    @phealth >= 110 ? true : false
  end

  def each_found_treasure
    @found_treasures.each do |name, points|
      yield Treasure.new(name, points)
    end
  end

  private
    def as_at
      Time.now.strftime("%I:%M:%S")
    end
end

if __FILE__ == $0
  p1=Player.new('sean')
  p1.greet
  puts p1.pname
end
