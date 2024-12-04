RSpec.describe AOC::Day02a do
  it "using test data returns 2" do
    expect(AOC::Day02a.new("../../data/day02_test.txt").safe_reports).to eq(2)
  end
end
