module AOC
  class Day04a < Day
    def count_xmas
      input = File.readlines(@path, chomp: true)
      to_check =
        input +
        input.map(&:reverse) +
        verticals(input) +
        verticals(input).map(&:reverse) +
        diagonals(input) +
        diagonals(input).map(&:reverse)
      to_check.map(&method(:xmases)).sum
    end

    private

    def xmases(line)
      line.scan('XMAS').count
    end

    def exploded(input)
      input.map { |s| s.split('') }
    end

    def verticals(input)
      exploded(input).transpose.map(&:join)
    end
    
    def diagonals(input)
      exp = exploded(input)
      diagonals =
        (0...exp.size).reduce([]) do |acc, row|
          acc << (0...[exp.size, exp[0].size - row].min).reduce([]) do |d, i|
            d << exp[i][row + i]
          end.join('')
        end
      diagonals += (1...exp[0].size).reduce([]) do |acc, col|
        acc << (0...[exp.size, exp[0].size - col].min).reduce([]) do |d, i|
          d << exp[col + i][i]
        end.join('')
      end
      diagonals += (0...exp.size).reduce([]) do |acc, row|
        acc << (0...[exp.size - row, exp[row].size].min).reduce([]) do |d, i|
          d << exp[row + i][exp[0].size - 1 - i]
        end.join('')
      end
      diagonals + ((exp[0].size - 2).downto(0)).reduce([]) do |acc, col|
        acc << (0..[exp.size, col].min).reduce([]) do |d, i|
          d << exp[i][col - i]
        end.join('')
      end
    end
  end
end
