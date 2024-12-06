module AOC
  class Day06b < Day
    class Map
      class Guard
        def self.is_guard?(cell)
          ['^', 'v', '<', '>'].include?(cell)
        end

        def initialize(x, y, cell)
          @x = x
          @y = y
          @direction = cell_to_direction(cell)
          @on_map = true
          @in_loop = false
          @visited = {[x,y] => 1}
          @turns = {}
        end

        def move(map)
          case next_cell(map)
          when '.'
            move_forward
          when '#'
            turn_right
          else
            @on_map = false
          end
        end

        def visited
          @visited
        end

        def visited_count
          @visited.keys.size
        end

        def on_map?
          @on_map
        end

        def in_loop?
          @in_loop
        end

        private
        def cell_to_direction(cell)
          case cell
          when '^' then :up
          when 'v' then :down
          when '<' then :left
          when '>' then :right
          end
        end

        def direction_to_cell(direction)
          case direction
          when :up  then '^'
          when :down then 'v'
          when :left then '<'
          when :right then '>'
          end
        end

        def next_cell(map)
          case @direction
          when :up
            return nil if @y - 1 < 0
            map[@y - 1][@x]
          when :down
            return nil if @y + 1 >= map.size
            map[@y + 1][@x]
          when :left
            return nil if @x - 1 < 0
            map[@y][@x - 1]
          when :right
            return nil if @x + 1 >= map[0].size
            map[@y][@x + 1]
          end
        end

        def move_forward
          case @direction
          when :up
            @y -= 1
          when :down
            @y += 1
          when :left
            @x -= 1
          when :right
            @x += 1
          end
          visit
        end

        def turn_right
          track_turn()
          case @direction
          when :up
            @direction = :right
          when :down
            @direction = :left
          when :left
            @direction = :up
          when :right
            @direction = :down
          end
        end

        def track_turn
          if @turns.has_key?([@x, @y, @direction])
            @in_loop = true
            @turns[[@x, @y, @direction]] += 1
          else
            @turns[[@x, @y, @direction]] = 1
          end
        end

        def visit
          if @visited.has_key?([@x, @y])
            @visited[[@x, @y]] += 1
          else
            @visited[[@x, @y]] = 1
          end
        end
      end

      def initialize(input)
        @map = input.map { |line| line.split('') }
        @guard = find_guard()
      end

      def add_obstruction(x, y)
        @map[y][x] = '#'
      end

      def move_guard()
        while @guard.on_map? && !@guard.in_loop?
          @guard.move(@map)
        end
      end

      def visited_cells
        @guard.visited.keys
      end

      def visited_cell_count
        @guard.visited_count
      end

      def guard_on_map?
        @guard.on_map?
      end

      def guard_in_loop?
        @guard.in_loop?
      end
  
      private

      def find_guard()
        @map.each_with_index do |row, y|
          row.each_with_index do |cell, x|
            if Guard.is_guard?(cell)
              @map[y][x] = '.'
              return Guard.new(x, y, cell)
            end
          end
        end
      end
    end

    def find_valid_obstructions
      @map = Map.new(@input)
      @map.move_guard
      @map.visited_cells.filter do |cell|
        map = Map.new(@input)
        map.add_obstruction(cell[0], cell[1])
        map.move_guard
        map.guard_in_loop?
      end.size
    end

    def map
      @map
    end
  end
end
