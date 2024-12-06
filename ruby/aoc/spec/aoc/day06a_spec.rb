RSpec.describe AOC::Day06a do
  it "using test data returns 41" do
    expect(AOC::Day06a.new("../../data/day06_test.txt").track_guard).to eq(41)
  end
end
