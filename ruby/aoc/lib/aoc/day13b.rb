module AOC
  class Day13b < Day
    class Machine
      attr_reader :ax, :ay, :bx, :by, :px, :py
      def initialize(lines)
        /X\+(\d+), Y\+(\d+)/.match(lines[0]) do |m|
          @ax = m[1].to_i
          @ay = m[2].to_i
        end
        /X\+(\d+), Y\+(\d+)/.match(lines[1]) do |m|
          @bx = m[1].to_i
          @by = m[2].to_i
        end
        /X\=(\d+), Y\=(\d+)/.match(lines[2]) do |m|
          @px = m[1].to_i + 10_000_000_000_000
          @py = m[2].to_i + 10_000_000_000_000
        end
      end

      def minimum_tokens
        return nil if (py*ax - px*ay).modulo(by*ax - bx*ay) != 0
        b = (py*ax - px*ay)/(by*ax - bx*ay)
        return nil if (px - b*bx).modulo(ax) != 0
        a = (px - b*bx)/ax
        return nil if a < 0 || b < 0
        a*3 + b
      end
    end

    def initialize(path)
      super
      @machines =
        @input
          .chunk_while {|a,b| b != "" && a != ""}
          .reject {|e| e[0] == ""}
          .map {|m| Machine.new(m)}
    end

    def minimum_tokens
      @machines.map(&:minimum_tokens).reject(&:nil?).sum
    end
  end
end
