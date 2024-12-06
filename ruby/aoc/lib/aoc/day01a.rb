module AOC
  class Day01a < Day
    def list_distance
      @input
        .map(&method(:parse))
        .then(&method(:sort))
        .map(&method(:distance))
        .sum
    end

    private

    def parse(line)
      line.split(/\s+/).map(&:to_i)
    end

    def sort(lines)
      left, right = lines.transpose
      left.sort.zip(right.sort)
    end

    def distance(pair)
      left, right = pair
      (right - left).abs
    end
  end
end
