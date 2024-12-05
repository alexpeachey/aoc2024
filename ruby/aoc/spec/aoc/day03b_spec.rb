RSpec.describe AOC::Day03b do
  it "using test data returns 48" do
    expect(AOC::Day03b.new("../../data/day03_test2.txt").run).to eq(48)
  end
end
