RSpec.describe AOC::Day07b do
  it "using test data returns 11387" do
    expect(AOC::Day07b.new("../../data/day07_test.txt").calibrate).to eq(11387)
  end
end
