RSpec.describe AOC::Day12b do
  it "using test data returns 1206" do
    expect(AOC::Day12b.new("../../data/day12_test.txt").calculate_price).to eq(1206)
  end
end
