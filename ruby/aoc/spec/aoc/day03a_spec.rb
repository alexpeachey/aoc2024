RSpec.describe AOC::Day03a do
  it "using test data returns 161" do
    expect(AOC::Day03a.new("../../data/day03_test.txt").run).to eq(161)
  end
end
