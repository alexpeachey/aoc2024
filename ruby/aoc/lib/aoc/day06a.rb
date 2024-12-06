module AOC
  class Day06a < Day
    class Map
      class Guard
        require 'curses'

        def self.is_guard?(cell)
          ['^', 'v', '<', '>'].include?(cell)
        end

        def initialize(x, y, cell, viewer)
          @x = x
          @y = y
          @direction = cell_to_direction(cell)
          @on_map = true
          @visited = {[x,y] => 1}
          @viewer = viewer
          init_viewer
        end

        def move(map)
          case next_cell(map)
          when '.'
            sleep(0.001) if @viewer
            move_forward
          when '#'
            sleep(0.5) if @viewer
            turn_right
          else
            @on_map = false
          end
          update_viewer(map)
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

        def visit
          if @visited.has_key?([@x, @y])
            @visited[[@x, @y]] += 1
          else
            @visited[[@x, @y]] = 1
          end
        end

        def init_viewer
          return unless @viewer
          Curses.init_screen
          @window = Curses::Window.new(9, 7, 2, 2)
          #@window.box('|', '-')
          @window.refresh
        end

        def update_viewer(map)
          return unless @viewer
          lines = determine_view_lines(map)
          lines.each_with_index do |line, i|
            @window.setpos(i + 1, 1)
            @window.addstr(line)
          end
          @window.setpos(6, 0)
          @window.addstr(visited_count.to_s)
          @window.refresh
        end

        def determine_view_lines(map)
          guard = direction_to_cell(@direction)
          [
            [view_cell(map, -2, -2), view_cell(map, -2, -1), view_cell(map, -2, 0), view_cell(map, -2, 1), view_cell(map, -2, 2)],
            [view_cell(map, -1, -2), view_cell(map, -1, -1), view_cell(map, -1, 0), view_cell(map, -1, 1), view_cell(map, -1, 2)],
            [view_cell(map, 0, -2), view_cell(map, 0, -1), guard, view_cell(map, 0, 1), view_cell(map, 0, 2)],
            [view_cell(map, 1, -2), view_cell(map, 1, -1), view_cell(map, 1, 0), view_cell(map, 1, 1), view_cell(map, 1, 2)],
            [view_cell(map, 2, -2), view_cell(map, 2, -1), view_cell(map, 2, 0), view_cell(map, 2, 1), view_cell(map, 2, 2)]
          ].map { |line| line.join('') }
        end

        def view_cell(map, dy, dx)
          return '_' if map[@y + dy].nil?
          return '_' if map[@y + dy][@x + dx].nil?
          map[@y + dy][@x + dx]
        end
      end

      def initialize(input, viewer)
        @map = input.map { |line| line.split('') }
        @guard = find_guard(viewer)
      end

      def move_guard()
        while @guard.on_map?
          @guard.move(@map)
        end
      end

      def visited
        @guard.visited
      end

      def visited_count
        @guard.visited_count
      end
  
      private

      def find_guard(viewer)
        @map.each_with_index do |row, y|
          row.each_with_index do |cell, x|
            if Guard.is_guard?(cell)
              @map[y][x] = '.'
              return Guard.new(x, y, cell, viewer)
            end
          end
        end
      end
    end

    def track_guard(viewer=false)
      @map = Map.new(@input, viewer)
      @map.move_guard
      @map.visited_count
    end

    def map
      @map
    end
  end
end
