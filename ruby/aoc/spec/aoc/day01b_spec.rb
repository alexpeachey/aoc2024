RSpec.describe AOC::Day01b do
  it "using test data returns 31" do
    expect(AOC::Day01b.new("../../data/day01_test.txt").list_similarity).to eq(31)
  end

  it "using alt test data returns 31" do
    expect(AOC::Day01b.new("../../data/day01_test2.txt").list_similarity).to eq(31)
  end
end
