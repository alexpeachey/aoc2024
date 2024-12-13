module AOC
  class Day12b < Day
    # Todo: Clean this horrible mess up
    class Plot
      attr_reader :x, :y

      def initialize(x, y)
        @x = x
        @y = y
      end

      def adjacent?(plot)
        (plot.x - x).abs + (plot.y - y).abs == 1
      end

      def ==(plot)
        x == plot.x && y == plot.y
      end

      def to_s
        "(#{x}, #{y})"
      end

      def inspect
        [x, y].inspect
      end
    end

    class Region
      attr_reader :plots
      def initialize(plot)
        @plots = [plot]
      end

      def area
        @plots.size
      end

      def fences(garden)
        horizontal = plots.sort do |a, b|
          if a.y == b.y
            a.x <=> b.x
          else
            a.y <=> b.y
          end
        end
        
        top =
          horizontal
          .reject { |plot| plot.y > 0 && garden[plot.y - 1][plot.x] == garden[plot.y][plot.x] }
          .chunk_while { |a, b| contiguous_top_fence?(a, b, garden) }
          .to_a
          .size
        
        bottom =
          horizontal
          .reject { |plot| plot.y < garden.size - 1 && garden[plot.y + 1][plot.x] == garden[plot.y][plot.x] }
          .chunk_while { |a, b| contiguous_bottom_fence?(a, b, garden) }
          .to_a
          .size
        
        vertical = plots.sort do |a, b|
          if a.x == b.x
            a.y <=> b.y
          else
            a.x <=> b.x
          end
        end
        
        left =
          vertical
          .reject { |plot| plot.x > 0 && garden[plot.y][plot.x - 1] == garden[plot.y][plot.x] }
          .chunk_while { |a, b| contiguous_left_fence?(a, b, garden) }
          .to_a
          .size
        
        right =
          vertical
          .reject { |plot| plot.x < garden[0].size - 1 && garden[plot.y][plot.x + 1] == garden[plot.y][plot.x] }
          .chunk_while { |a, b| contiguous_right_fence?(a, b, garden) }
          .to_a
          .size
        top + bottom + left + right
      end

      def contiguous_top_fence?(a, b, garden)
        return false if a.y != b.y
        return false if a.x + 1 != b.x
        return true if a.y == 0
        garden[a.y - 1][a.x] != garden[a.y][a.x] && garden[b.y - 1][b.x] != garden[b.y][b.x]
      end

      def contiguous_bottom_fence?(a, b, garden)
        return false if a.y != b.y
        return false if a.x + 1 != b.x
        return true if a.y == garden.size - 1
        garden[a.y + 1][a.x] != garden[a.y][a.x] && garden[b.y + 1][b.x] != garden[b.y][b.x]
      end

      def contiguous_left_fence?(a, b, garden)
        return false if a.x != b.x
        return false if a.y + 1 != b.y
        return true if a.x == 0
        garden[a.y][a.x - 1] != garden[a.y][a.x] && garden[b.y][b.x - 1] != garden[b.y][b.x]
      end

      def contiguous_right_fence?(a, b, garden)
        return false if a.x != b.x
        return false if a.y + 1 != b.y
        return true if a.x == garden[0].size - 1
        garden[a.y][a.x + 1] != garden[a.y][a.x] && garden[b.y][b.x + 1] != garden[b.y][b.x]
      end

      def contains?(plot)
        @plots.any? { |p| p == plot }
      end

      def adjacent?(plot)
        @plots.any? { |p| p.adjacent?(plot) }
      end

      def add_plot(plot)
        return self if contains?(plot)
        if adjacent?(plot)
          @plots << plot
        end
        self
      end

      def merge(region)
        @plots += region.plots
        @plots.uniq!
        self
      end
    end

    class Crop
      attr_reader :crop, :regions

      def initialize(crop)
        @crop = crop
        @regions = []
      end

      def add_plot(plot)
        adjacent = regions.select { |region| region.adjacent?(plot) }
        if adjacent.size == 0
          @regions << Region.new(plot)
        elsif adjacent.size == 1
          region = @regions.delete(adjacent.first)
          region.add_plot(plot)
          @regions << region
        else
          adjacent.each { |region| @regions.delete(region) }
          region = adjacent.reduce(Region.new(plot)) { |acc, r| acc.merge(r) }
          @regions << region
        end
      end
    end

    def calculate_price
      crops.values.map do |crop|
        crop.regions.map do |region|
          region.area * region.fences(garden)
        end.sum
      end.sum
    end

    def garden
      @garden ||= @input.map { |line| line.split('') }
    end

    def crops
      return @crops if @crops
      @crops = {}
      garden.each_with_index do |row, y|
        row.each_with_index do |crop, x|
          @crops[crop] ||= Crop.new(crop)
          @crops[crop].add_plot(Plot.new(x, y))
        end
      end
      @crops
    end
  end
end
