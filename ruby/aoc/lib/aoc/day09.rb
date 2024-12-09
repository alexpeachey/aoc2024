module AOC
  class Day09a < Day
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
      (@disk_map.size - 1).downto(0).each do |i|
        d = @disk_map[i]
        next if d.nil?
        move_to = @disk_map.find_index { |d| d.nil? }
        next if move_to > i
        @disk_map[move_to] = d
        @disk_map[i] = nil
      end
    end
  end
end
