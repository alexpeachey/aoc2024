module AOC
  class Day07b < Day
    class Value
      attr_reader :value
      
      def initialize(value)
        @value = value.to_i
      end

      def +(other)
        Value.new(@value + other.value)
      end

      def *(other)
        Value.new(@value * other.value)
      end

      def **(other)
        Value.new(@value.to_s + other.value.to_s)
      end
    end

    def calibrate
      @input
        .map(&method(:parse))
        .filter(&method(:possible))
        .map(&:first)
        .sum
    end

    private

    def parse(line)
      result, values = line.split(':')
      values = values.split(' ').map(&:to_i)
      [result.to_i, values]
    end

    def possible(line)
      result, values = line
      reduce_values(values, [:+, :*, :**]).include?(result)
    end

    def reduce_values(values, operators)
      operators
        .repeated_permutation(values.size - 1)
        .map do |ops|
          operands = values.map { |v| Value.new(v) }
          ops.reduce(operands) do |acc, op|
            a, b = acc.shift(2)
            acc.unshift(a.send(op, b))
          end.first.value
        end
    end
  end
end
