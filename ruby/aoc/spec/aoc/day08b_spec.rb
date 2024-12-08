RSpec.describe AOC::Day08b do
  it "using test data returns 34" do
    expect(AOC::Day08b.new("../../data/day08_test.txt").antinode_count).to eq(34)
  end
end
