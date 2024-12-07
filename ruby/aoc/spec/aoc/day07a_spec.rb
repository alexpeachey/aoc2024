RSpec.describe AOC::Day07a do
  it "using test data returns 3749" do
    expect(AOC::Day07a.new("../../data/day07_test.txt").calibrate).to eq(3749)
  end
end
