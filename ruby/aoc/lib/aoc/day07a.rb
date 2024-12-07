module AOC
  class Day07a < Day
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
      reduce_values(values, [:+, :*]).include?(result)
    end

    def reduce_values(values, operators)
      operators
        .repeated_permutation(values.size - 1)
        .map do |ops|
          ops.reduce(values.clone) do |acc, op|
            a, b = acc.shift(2)
            acc.unshift(a.send(op, b))
          end.first
        end
    end
  end
end
