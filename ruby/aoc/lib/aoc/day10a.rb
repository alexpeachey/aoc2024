module AOC
  class Day10a < Day
    class Trail
      attr_reader :trail_head, :route

      def initialize(trail_head)
        @trail_head = trail_head
        @route = []
      end

      def add_stop(x, y)
        @route << [x, y]
      end

      def length
        @route.length + 1
      end

      def fork
        trail = Trail.new(@trail_head)
        @route.each do |stop|
          trail.add_stop(stop[0], stop[1])
        end
        trail
      end
    end

    def initialize(input)
      super
      @map =
        @input
          .map { |line| line.split('') }
          .map { |row| row.map(&:to_i) }
      @maxx = @map[0].length
      @maxy = @map.length
    end

    def total_trailhead_score
      map_trails
      @trails
        .reject { |trail| trail.length < 10 }
        .group_by(&:trail_head)
        .map do |head, trails|
          trails
            .map {|t| t.route.last || t.trail_head}
            .uniq
            .length
        end
        .sum
    end

    def map_trails
      @trails = []
      trailheads do |x, y|
        @trails += map_trail(Trail.new([x, y])).flatten
      end
    end

    private

    def trailheads &block
      @map.each_with_index do |row, y|
        row.each_with_index do |cell, x|
          yield(x, y) if cell == 0
        end
      end
    end

    def map_trail(trail)
      cx, cy = trail.route.last || trail.trail_head
      alt = @map[cy][cx]
      return [trail] if alt == 9
      [[cx, cy - 1], [cx + 1, cy], [cx, cy + 1], [cx - 1, cy]]
        .reject(&method(:out_of_bounds?))
        .reject { |x, y| @map[y][x] - alt != 1 }
        .map do |x, y|
          new_trail = trail.fork
          new_trail.add_stop(x, y)
          map_trail(new_trail)
        end.compact
    end

    def out_of_bounds?(point)
      x, y = point
      x < 0 || x >= @maxx || y < 0 || y >= @maxy
    end
  end
end
