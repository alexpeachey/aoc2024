RSpec.describe AOC::Day01a do
  it "using test data returns 11" do
    expect(AOC::Day01a.new("../../data/day01_test.txt").list_distance).to eq(11)
  end

  it "using alt test data returns 11" do
    expect(AOC::Day01a.new("../../data/day01_test2.txt").list_distance).to eq(11)
  end
end
