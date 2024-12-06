RSpec.describe AOC::Day04b do
  it "using test data returns 9" do
    expect(AOC::Day04b.new("../../data/day04_test.txt").count_xmas).to eq(9)
  end
end
