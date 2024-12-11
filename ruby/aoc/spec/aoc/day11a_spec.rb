RSpec.describe AOC::Day11a do
  it "using test data returns 55312" do
    expect(AOC::Day11a.new("../../data/day11_test.txt").blink(25)).to eq(55312)
  end
end
