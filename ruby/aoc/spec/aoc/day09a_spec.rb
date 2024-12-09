RSpec.describe AOC::Day09a do
  it "using test data returns 1928" do
    expect(AOC::Day09a.new("../../data/day09_test.txt").checksum).to eq(1928)
  end
end
