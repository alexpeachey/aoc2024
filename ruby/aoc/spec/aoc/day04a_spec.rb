RSpec.describe AOC::Day04a do
  it "using test data returns 18" do
    expect(AOC::Day04a.new("../../data/day04_test.txt").count_xmas).to eq(18)
  end
end
