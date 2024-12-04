RSpec.describe AOC::Day02b do
  it "using test data returns 4" do
    expect(AOC::Day02b.new("../../data/day02_test.txt").safe_reports).to eq(4)
  end
end
