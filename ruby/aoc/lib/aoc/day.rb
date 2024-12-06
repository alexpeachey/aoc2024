module AOC
  class Day
    def initialize(path)
      @path = path
      @input = File.readlines(@path, chomp: true)
    end
  end
end
