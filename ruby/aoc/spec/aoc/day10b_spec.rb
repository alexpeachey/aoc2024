RSpec.describe AOC::Day10b do
  it "using test data returns 81" do
    expect(AOC::Day10b.new("../../data/day10_test.txt").total_trailhead_score).to eq(81)
  end
end
