module AOC
  class Day01b < Day
    def list_similarity
      @input
        .map(&method(:parse))
        .then(&method(:frequency))
        .map(&method(:similarity))
        .sum
    end

    private

    def parse(line)
      line.split(/\s+/).map(&:to_i)
    end

    def frequency(lines)
      left, right = lines.transpose
      @tally = right.tally
      left
    end

    def similarity(value)
      value * @tally.fetch(value, 0)
    end
  end
end
