RSpec.describe AOC::Day13a do
  it "using test data returns 480" do
    expect(AOC::Day13a.new("../../data/day13_test.txt").minimum_tokens).to eq(480)
  end
end
