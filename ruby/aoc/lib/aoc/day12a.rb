module AOC
  class Day12a < Day
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
    end

    class Region
      attr_reader :plots
      def initialize(plot)
        @plots = [plot]
      end

      def area
        @plots.size
      end

      def perimeter(garden)
        @plots.map do |plot|
          fences = 0
          fences += 1 if plot.x == 0
          fences += 1 if plot.y == 0
          fences += 1 if plot.x == garden[0].size - 1
          fences += 1 if plot.y == garden.size - 1
          fences += 1 if plot.x - 1 >= 0 && garden[plot.y][plot.x - 1] != garden[plot.y][plot.x]
          fences += 1 if plot.x + 1 < garden[0].size && garden[plot.y][plot.x + 1] != garden[plot.y][plot.x]
          fences += 1 if plot.y - 1 >= 0 && garden[plot.y - 1][plot.x] != garden[plot.y][plot.x]
          fences += 1 if plot.y + 1 < garden.size && garden[plot.y + 1][plot.x] != garden[plot.y][plot.x]
          fences
        end.sum
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
          region.area * region.perimeter(garden)
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
