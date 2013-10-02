require_relative '../dice'
describe Dice do

  before do
    $stdout = StringIO.new
    @myroll = Dice.new(6).roll
  end

  it "roll should be less than die" do
    @myroll.should <= 6
  end
end
