module AOC
  class Day03b < Day
    def run
      @input
        .join("")
        .then(&method(:parse_instructions))
        .reduce([0, :do], &method(:execute))
        .first
    end

    private

    def parse_instructions(input)
      input
        .scan(/mul\((\d{1,3})\,(\d{1,3})\)|(don't\(\))|(do\(\))/)
        .map {|r| r.reject(&:nil?)}
    end

    def execute(acc, instruction)
      total, action = acc
      case instruction
      when ["don't()"]
        [total, :dont]
      when ["do()"]
        [total, :do]
      else
        [total + multiply(instruction, action), action]
      end
    end

    def multiply(pair, action)
      if action == :do
        pair.map(&:to_i).reduce(&:*)
      else
        0
      end
    end
  end
end
