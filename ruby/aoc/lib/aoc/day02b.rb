module AOC
  class Day02b < Day
    def safe_reports
      @input
        .map(&method(:parse))
        .filter(&method(:safe_with_dampener?))
        .count
    end

    private

    def parse(line)
      line.split(/\s+/).map(&:to_i)
    end

    def safe_with_dampener?(list)
      safe?(list) ||
      dampened_errors(list).any?(&method(:safe?))
    end

    def dampened_errors(list)
      list.map.with_index do |n, i|
        dampened = list.dup
        dampened.delete_at(i)
        dampened
      end
    end

    def safe?(list)
      ((ascending?(list) || descending?(list)) && gradual?(list))
    end

    def ascending?(list)
      list.sort == list
    end

    def descending?(list)
      list.sort.reverse == list
    end

    def gradual?(list)
      list.zip(list.drop(1)).all?(&method(:small_delta?))
    end

    def small_delta?(pair)
      a, b = pair
      return true if b.nil?
      1 <= (b - a).abs && (b - a).abs <= 3
    end
  end
end
