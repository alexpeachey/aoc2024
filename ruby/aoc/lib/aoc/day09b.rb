module AOC
  class Day09b < Day
    attr_reader :disk_map

    def initialize(path)
      super
      @disk_map =
        @input
        .first
        .split((''))
        .map(&:to_i)
        .each_with_index
        .group_by { |d, i| i.even? }
        .map { |_, clump| clump.map { |d| d[0]}}
        .then { |clumps| clumps[0].zip(clumps[1])}
        .each_with_index
        .map do |pair, i|
          f_size, ws_size = pair
          f_exp = (0...f_size).map { |_| i}
          if ws_size.nil?
            ws_exp = []
          else
            ws_exp = (0...ws_size).map { |_| nil}
          end
          f_exp + ws_exp
        end
        .flatten
      compact()
    end

    def checksum
      @disk_map.each_with_index.map do |d, i|
        if d.nil?
          0
        else
          d * i
        end
      end.sum
    end
      
    private

    def compact
      chunked = @disk_map.chunk_while { |a, b| a == b }.to_a
      files_to_move = chunked.reverse
      files_to_move.each do |chunk|
        next if chunk.all?(&:nil?)
        move_to = chunked.find_index { |space| space.all?(&:nil?) && space.size >= chunk.size }
        next if move_to.nil?
        current = chunked.find_index(chunk)
        next if move_to > current
        empty = chunked[move_to]
        empty = empty[chunk.size..-1]
        chunked[current] = chunk.map { |_| nil }        
        chunked[move_to] = chunk
        chunked.insert(move_to + 1, empty) if empty.size > 0
      end
      @disk_map = chunked.flatten
    end
  end
end
