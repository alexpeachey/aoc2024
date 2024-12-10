RSpec.describe AOC::Day10a do
  it "using test data returns 36" do
    expect(AOC::Day10a.new("../../data/day10_test.txt").total_trailhead_score).to eq(36)
  end
end
