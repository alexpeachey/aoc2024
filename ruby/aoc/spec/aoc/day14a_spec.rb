RSpec.describe AOC::Day14a do
  it "using test data returns 12" do
    expect(AOC::Day14a.new("../../data/day14_test.txt").safety_factor_after(100, [11,7])).to eq(12)
  end
end
