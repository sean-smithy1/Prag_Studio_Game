require_relative '../game'
require_relative '../dice'

describe Game do

  before do
    $stdout = StringIO.new
    @initial_health = 100
    @game=Game.new("Knuckleheads")
    @player =Player.new("sean", @initial_health)
    @game.add_player(@player)
   end

  it "high number is rolled" do
    Dice.any_instance.stub(:roll).and_return(5)
    Dice.any_instance.stub(:heal).and_return(15)
    @game.play(2)
    @player.phealth.should == @initial_health + 15*2
  end

  it "medium number rolled returns" do
    Dice.any_instance.stub(:roll).and_return(3)
    @game.play(2)
    @player.phealth.should == @initial_health
  end

  it "low number rolled" do
    Dice.any_instance.stub(:roll).and_return(1)
    Dice.any_instance.stub(:damage).and_return(15)
    @game.play(2)
    @player.phealth.should == @initial_health - 15*2
  end

  it "assigns a treasure for points during a player's turn" do
    game = Game.new("Knuckleheads")
    player = Player.new("moe")

    game.add_player(player)

    game.play(1)

    player.points.should_not be_zero
  end
end
