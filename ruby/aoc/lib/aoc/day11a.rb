module AOC
  class Day11a < Day
    class Stone
      @@multiplier = 2024

      def initialize(value)
        @digits = value.to_s.to_i.to_s.split('').map(&:to_i)
      end

      def blink
        if zero?
          @digits = [1]
          self
        elsif even?
          split
        else
          Stone.new(value * @@multiplier)
        end
      end

      def value
        @digits.join.to_i
      end

      def zero?
        @digits.size == 1 && @digits[0] == 0
      end

      def even?
        @digits.size.even?
      end

      def split
        return if @digits.size.odd?
        left, right = @digits.each_slice(@digits.size / 2).to_a
        [Stone.new(left.join), Stone.new(right.join)]
      end
    end

    def initialize(path)
      super
      @stones = @input.first.split(' ').map { |s| Stone.new(s) }
    end

    def blink(n)
      (1..n).reduce(@stones) do |stones, _|
        stones.map(&:blink).flatten
      end.size
    end
  end
end
