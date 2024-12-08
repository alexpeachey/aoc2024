RSpec.describe AOC::Day08a do
  it "using test data returns 14" do
    expect(AOC::Day08a.new("../../data/day08_test.txt").antinode_count).to eq(14)
  end
end
