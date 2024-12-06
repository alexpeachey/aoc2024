module AOC
  class Day05b < Day
    def sum_invalid_middles
      rules, _, print_orders =
        File.readlines(@path, chomp: true)
          .chunk { |line| line.empty? }
          .map { |_, lines| lines }
      
      rules = parse_rules(rules)
      print_orders = parse_print_orders(print_orders)

      print_orders
        .filter { |order| !valid?(order, rules) }
        .map { |order| fix_order(order, rules) }
        .map(&method(:middle))
        .sum
    end

    private

    def fix_order(order, rules)
      relevant = rules.filter { |rule| order.include?(rule[0]) && order.include?(rule[1]) }
      order.sort do |a, b|
        if relevant.include?([a, b])
          -1
        elsif relevant.include?([b, a])
          1
        else
          a <=> b
        end
      end
    end

    def valid?(order, rules)
      (0...order.size).all? do |i|
        order[0,i].all? { |p| rules.include?([p, order[i]]) } &&
        order[i+1..].all? { |p| rules.include?([order[i], p]) }
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
        .map { |rule| rule.map(&:to_i) }
    end
  end
end
