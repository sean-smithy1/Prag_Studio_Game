require_relative '../player.rb'
require_relative '../treasure_trove.rb'

describe Player do

  before do
    $stdout = StringIO.new
    @player =Player.new("larry")
  end

  it "should start with a Capital" do
    @player.pname.should == "Larry"
  end

  it "has a default health of 100" do
    @player.phealth.should == 100
  end

  it "should heal" do
    orghealth = @player.phealth
    @player.heal(10)
    @player.phealth == orghealth+10
  end

  it "computes points as the sum of all treasure points" do
    @player.points.should == 0
    @player.found_treasure(Treasure.new(:hammer, 50))
    @player.points.should == 50
    @player.found_treasure(Treasure.new(:crowbar, 400))
    @player.points.should == 450
    @player.found_treasure(Treasure.new(:hammer, 50))
    @player.points.should == 500
  end

  it "computes a score as the sum of its health and points" do
    @player.found_treasure(Treasure.new(:hammer, 50))
    @player.found_treasure(Treasure.new(:hammer, 50))

    @player.score.should == 200
  end

it "has a string representation" do
  @player.found_treasure(Treasure.new(:hammer, 50))
  @player.found_treasure(Treasure.new(:hammer, 50))
  @player.to_s.should == "I'm Larry with health = 100, points = 100, and score = 200."
end

it "yields each found treasure and its total points" do
  @player.found_treasure(Treasure.new(:skillet, 100))
  @player.found_treasure(Treasure.new(:skillet, 100))
  @player.found_treasure(Treasure.new(:hammer, 50))
  @player.found_treasure(Treasure.new(:bottle, 5))
  @player.found_treasure(Treasure.new(:bottle, 5))
  @player.found_treasure(Treasure.new(:bottle, 5))
  @player.found_treasure(Treasure.new(:bottle, 5))
  @player.found_treasure(Treasure.new(:bottle, 5))

  yielded = []
  @player.each_found_treasure do |treasure|
    yielded << treasure
  end

  yielded.should == [
    Treasure.new(:skillet, 200),
    Treasure.new(:hammer, 50),
    Treasure.new(:bottle, 25)
  ]
  end

  context "Player with health greater than 100" do
    before do
      @player=Player.new("sean", 150)
    end
    it "is strong" do
      @player.should be_strong
    end
  end

  context "Wimpy Character" do
    before do
      @player=Player.new("Sandy", 100)
    end
    it "is wimpy" do
      @player.should_not be_strong
    end
  end

  context "in a collection of players" do
    before do
      @player1 = Player.new("moe", 100)
      @player2 = Player.new("larry", 200)
      @player3 = Player.new("curly", 300)

      @players = [@player1, @player2, @player3]
    end

    it "is sorted by decreasing score" do
      @players.sort.should == [@player3, @player2, @player1]
    end
  end
end
