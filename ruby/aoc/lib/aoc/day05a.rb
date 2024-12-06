module AOC
  class Day05a < Day
    def sum_valid_middles
      rules, _, print_orders =
        @input
          .chunk { |line| line.empty? }
          .map { |_, lines| lines }
      
      @rules = parse_rules(rules)
      @print_orders = parse_print_orders(print_orders)

      @print_orders
        .filter(&method(:valid?))
        .map(&method(:middle))
        .sum
    end

    private

    def valid?(order)
      (0...order.size).all? do |i|
        order[0,i].all? { |p| @rules.include?([p, order[i]]) } &&
        order[i+1..].all? { |p| @rules.include?([order[i], p]) }
      end
    end

    def middle(order)
      order[order.size / 2]
    end

    def parse_rules(rules)
      rules
        .map { |rule| rule.split('|') }
        .map { |rule| rule.map(&:to_i) }
    end

    def parse_print_orders(print_orders)
      print_orders
        .map { |order| order.split(',') }
        .map { |order| order.map(&:to_i) }
    end
  end
end
