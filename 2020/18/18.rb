require 'strscan'
input = File.read("input").split("\n")
input.map!{|line| line.delete(' ')}

def parse_add_mul(expression)
  scanner = StringScanner.new(expression)
  if scanner.scan_until(/(\d+)(\+|\*)(\d+)/) != nil
    first, op, second = scanner[1].to_i, scanner[2], scanner[3].to_i
    case op
    when "+"
      first = first + second
    when "*"
      first = first * second
    end
    return parse_add_mul(scanner.pre_match + first.to_s + scanner.post_match)
  end

  return expression.to_i
end

def parse_add(expression)
  scanner = StringScanner.new(expression)
  if scanner.scan_until(/(\d+)\+(\d+)/) != nil
    return parse_add(scanner.pre_match + (scanner[1].to_i + scanner[2].to_i).to_s + scanner.post_match)
  end
  return parse_add_mul(expression)
end

def parse_parenthesies(expression, evaluator)
  scanner = StringScanner.new(expression)
  if scanner.scan_until(/\(([\d\+\*]+)\)/) != nil
    return parse_parenthesies(scanner.pre_match + evaluator.call(scanner[1]).to_s + scanner.post_match, evaluator)
  end
  return evaluator.call(expression)
end

print "Part One: "
p input.map{|task| parse_parenthesies(task, method(:parse_add_mul))}.reduce(:+)

print "Part Two: "
p input.map{|task| parse_parenthesies(task, method(:parse_add))}.reduce(:+)

