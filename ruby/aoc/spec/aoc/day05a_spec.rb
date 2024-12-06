RSpec.describe AOC::Day05a do
  it "using test data returns 143" do
    expect(AOC::Day05a.new("../../data/day05_test.txt").sum_valid_middles).to eq(143)
  end
end
