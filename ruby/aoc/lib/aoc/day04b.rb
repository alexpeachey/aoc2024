module AOC
  class Day04b < Day
    def count_xmas
      find_xmas(
        exploded(
          File.readlines(@path, chomp: true)
          )
      )
    end

    private

    def find_xmas(matrix)
      (1..matrix.size - 2).reduce(0) do |acc, row|
        acc + (1..matrix[0].size - 2).reduce(0) do |acc2, col|
          acc2 + xmas(matrix, row, col)
        end
      end
    end

    def xmas(matrix, row, col)
      return 0 if matrix[row][col] != 'A'
      a = matrix[row-1][col-1] + 'A' + matrix[row+1][col+1]
      b = matrix[row-1][col+1] + 'A' + matrix[row+1][col-1]
      return 1 if a == 'MAS' && b == 'MAS'
      return 1 if a == 'SAM' && b == 'SAM'
      return 1 if a == 'SAM' && b == 'MAS'
      return 1 if a == 'MAS' && b == 'SAM'
      0
    end

    def exploded(input)
      input.map { |s| s.split('') }
    end
  end
end
