module AOC
  class Day11b < Day
    class Stone
      @@multiplier = 2024

      def initialize(value)
        @digits = value.to_s.to_i.to_s.split('').map(&:to_i)
      end

      def blink
        if zero?
          @digits = [1]
          [self]
        elsif even?
          split
        else
          [Stone.new(value * @@multiplier)]
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
      cache = Hash.new(0)
      @stones.each { |stone| cache[stone.value] += 1 }
      (1..n).reduce(cache) do |cache, _|
        cache.reduce(Hash.new(0)) do |acc, stone_cache|
          value, count = stone_cache
          Stone.new(value).blink.flatten.each do |stone|
            acc[stone.value] += count
          end
          acc
        end
      end.values.sum
    end
  end
end
