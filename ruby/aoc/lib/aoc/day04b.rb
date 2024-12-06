module AOC
  class Day04b < Day
    def count_xmas
      explode()
      find_xmas()
    end

    private

    def find_xmas()
      (1..@exp.size - 2).reduce(0) do |acc, row|
        acc + (1..@exp[0].size - 2).reduce(0) do |acc2, col|
          acc2 + xmas(row, col)
        end
      end
    end

    def xmas(row, col)
      return 0 if @exp[row][col] != 'A'
      a = @exp[row-1][col-1] + 'A' + @exp[row+1][col+1]
      b = @exp[row-1][col+1] + 'A' + @exp[row+1][col-1]
      return 1 if a == 'MAS' && b == 'MAS'
      return 1 if a == 'SAM' && b == 'SAM'
      return 1 if a == 'SAM' && b == 'MAS'
      return 1 if a == 'MAS' && b == 'SAM'
      0
    end

    def explode()
      @exp ||= @input.map { |s| s.split('') }
    end
  end
end
