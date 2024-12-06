module AOC
  class Day03a < Day
    def run
      @input
        .join("")
        .then(&method(:parse_mul_instructions))
        .map(&method(:multiply))
        .sum
    end

    private

    def parse_mul_instructions(input)
      input.scan(/mul\((\d{1,3})\,(\d{1,3})\)/)
    end

    def multiply(pair)
      pair.map(&:to_i).reduce(&:*)
    end
  end
end
