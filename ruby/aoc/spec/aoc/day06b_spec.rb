RSpec.describe AOC::Day06b do
  it "using test data returns 6" do
    expect(AOC::Day06b.new("../../data/day06_test.txt").find_valid_obstructions).to eq(6)
  end
end
