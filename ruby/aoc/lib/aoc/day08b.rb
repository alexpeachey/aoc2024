module AOC
  class Day08b < Day
    class Frequency
      attr_reader :name, :nodes
      
      def initialize(name, maxx, maxy)
        @name = name
        @maxx = maxx
        @maxy = maxy
        @nodes = []
      end

      def add_node(node)
        @nodes << node
      end

      def anti_nodes
        @nodes.combination(2).map do |nodes|
          a, b = sort_nodes(nodes)
          dx = b[0] - a[0]
          dy = b[1] - a[1]
          anti1 = Enumerator.produce(b) do |position|
            x, y = position
            [x - dx, y - dy]
          end.take_while(&method(:in_bounds?))
          anti2 = Enumerator.produce(a) do |position|
            x, y = position
            [x + dx, y + dy]
          end.take_while(&method(:in_bounds?))
          anti1 + anti2
        end
        .flatten(1)
      end

      private
      def sort_nodes(nodes)
        nodes.sort do |a, b|
          if (a[0] <=> b[0]) == 0
            a[1] <=> b[1]
          else
            a[0] <=> b[0]
          end
        end
      end

      def in_bounds?(node)
        x, y = node
        x >= 0 && x <= @maxx && y >= 0 && y <= @maxy
      end
    end

    def initialize(path)
      super
      @map = @input.map(&method(:explode))
      maxx = @map.first.size - 1
      maxy = @map.size - 1
      @antennas = Hash.new { |h, k| h[k] = Frequency.new(k, maxx, maxy) }
      find_antennas()
    end

    def antinode_count
      @antennas
        .values
        .map(&:anti_nodes)
        .flatten(1)
        .uniq
        .size
    end

    private
    
    def explode(line)
      line.split('')
    end

    def find_antennas()
      @map.each_with_index.map do |row, y|
        row.each_with_index.map do |cell, x|
          [cell, [x, y]] if cell =~ /[A-Za-z0-9]/
        end
      end
      .flatten(1)
      .compact()
      .each do |antenna|
        name, position = antenna
        @antennas[name].add_node(position)
      end
    end
  end
end
