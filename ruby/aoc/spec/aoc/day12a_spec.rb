RSpec.describe AOC::Day12a do
  it "using test data returns 1930" do
    expect(AOC::Day12a.new("../../data/day12_test.txt").calculate_price).to eq(1930)
  end
end
