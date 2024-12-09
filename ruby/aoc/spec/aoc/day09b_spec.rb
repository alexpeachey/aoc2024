RSpec.describe AOC::Day09b do
  it "using test data returns 2858" do
    expect(AOC::Day09b.new("../../data/day09_test.txt").checksum).to eq(2858)
  end
end
