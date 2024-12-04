module AOC
  class Day02a < Day
    def safe_reports
      File.readlines(@path, chomp: true)
        .map(&method(:parse))
        .filter(&method(:safe?))
        .count
    end

    private

    def parse(line)
      line.split(/\s+/).map(&:to_i)
    end

    def safe?(list)
      (ascending?(list) || descending?(list)) && gradual?(list)
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
