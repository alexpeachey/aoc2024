module AOC
  class Robot
    attr_reader :x, :y, :dx, :dy

    def initialize(text)
      pos, vel = text.split(' ')
      _, xy = pos.split('=')
      @x, @y = xy.split(',').map(&:to_i)
      _, xy = vel.split('=')
      @dx, @dy = xy.split(',').map(&:to_i)
    end

    def move_within(bounds)
      width, height = bounds
      move_x_within(width)
      move_y_within(height)
      self
    end

    def move_x_within(width)
      case x + dx
      when 0..width - 1
        @x += dx
      when -> (newx) { newx < 0 }
        @x = width + (x + dx)
      else
        @x = (x + dx).modulo(width)
      end
    end

    def move_y_within(height)
      case y + dy
      when 0..height - 1
        @y += dy
      when -> (newy) { newy < 0 }
        @y = height + (y + dy)
      else
        @y = (y + dy).modulo(height)
      end
    end

    def to_s
      "Robot at (#{x},#{y}) moving at (#{dx},#{dy})"
    end

    def inspect
      to_s
    end
  end

  class Day14b < Day
    def initialize(path)
      super
      @robots = @input.map { |line| Robot.new(line) }
    end

    def find_tree(bounds)
      n = 0
      w, h = bounds
      (0..(w * h)).each do
        @robots.each { |robot| robot.move_within(bounds) }
        n += 1
        break if tree_like?(bounds)
      end
      display_robots(bounds)
      n
    end

    def tree_like?(bounds)
      w, h = bounds
      grid = (0...h).map { |y| (0...w).map { '.'} }
      @robots.each do |robot|
        grid[robot.y][robot.x] = '#'
      end
      grid.select { |row| row.join('') =~ /##########/ }.any?
    end

    def display_robots(bounds)
      w, h = bounds
      (0...h).each do |y|
        (0...w).each do |x|
          if @robots.any? { |r| r.x == x && r.y == y }
            print '#'
          else
            print '.'
          end
        end
        puts
      end
    end
  end
end
