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

  class Day14a < Day
    def initialize(path)
      super
      @robots = @input.map { |line| Robot.new(line) }
    end

    def safety_factor_after(n, bounds)
      n.times do
        @robots.each { |robot| robot.move_within(bounds) }
      end
      width, height = bounds
      midx = (bounds[0] / 2)
      midy = (bounds[1] / 2)
      q1 = @robots.select { |robot| robot.x < midx && robot.y < midy }#.tap { |r| p r.inspect }
      q2 = @robots.select { |robot| robot.x > midx && robot.y < midy }#.tap { |r| p r.inspect }
      q3 = @robots.select { |robot| robot.x < midx && robot.y > midy }#.tap { |r| p r.inspect }
      q4 = @robots.select { |robot| robot.x > midx && robot.y > midy }#.tap { |r| p r.inspect }
      q1.size * q2.size * q3.size * q4.size
    end
  end
end
