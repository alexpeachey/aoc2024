RSpec.describe AOC::Day05b do
  it "using test data returns 123" do
    expect(AOC::Day05b.new("../../data/day05_test.txt").sum_invalid_middles).to eq(123)
  end
end
