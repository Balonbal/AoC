require 'strscan'
rules, input = File.read("input").split("\n\n")
rules = rules.split("\n").map{|rule| rule.split(": ")}
input = input.split "\n"

rule_map = Hash.new
for num, rule in rules
  rule_map[num] = rule
end

def rule_expression(rule, rule_map, nesting = 0)
  return "x" if nesting > 100
  if m = rule.match(/"*(\w+)"/)
    return m[1]
  end

  scanner = StringScanner.new(rule)
  if scanner.scan_until /\|/
    return "(" + rule_expression(scanner.pre_match, rule_map, nesting + 1) + "|" + rule_expression(scanner.post_match, rule_map, nesting + 1) + ")"
  end

  expr = ""
  while scanner.scan /\s?(\d+)\s?/
    expr = expr + rule_expression(rule_map[scanner[1]], rule_map, nesting + 1)
  end
  return expr
end

validator = Regexp.new "^" + rule_expression(rule_map["0"], rule_map) + "$"

count = 0
for line in input
  count = count + 1 if line.match?(validator)
end
print "Part One: "
p count

rule_map["8"] = "42 | 42 8"
rule_map["11"] = "42 31 | 42 11 31"
validator = Regexp.new "^" + rule_expression(rule_map["0"], rule_map) + "$"

count = 0
for line in input
  count = count + 1 if line.match?(validator)
end
print "Part Two: "
p count 
