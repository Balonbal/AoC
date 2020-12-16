rules, ticket, other_tickets = File.read("input").split("\n\n")
rule_index = Hash.new
rules.split("\n").each.with_index{|rule, index|
  name, values = rule.split(": ")
  rule_index[name] = values.split(" or ").map{|rule| rule.split("-").map(&:to_i)}
}

my_ticket = ticket.split("\n")[1].split(",").map(&:to_i)

other_tickets = other_tickets.split("\n").map{|t| t.split(",").map(&:to_i)}
other_tickets.shift

invalid_tickets = 0

def field_valid?(value, rule, rules)
  for min, max in rules[rule]
    return true if value >= min and value <= max
  end
  return false
end

def invalid?(value, rules)
  for rule, _ in rules
    return false if field_valid?(value, rule, rules)
  end

  return true
end

invalid = []
for ticket in other_tickets
  for field in ticket
    if invalid?(field, rule_index)
      invalid_tickets = invalid_tickets + field 
      invalid.push(ticket)
    end
  end
end
print "Part One: "
p invalid_tickets 

valid_tickets = other_tickets - invalid

def field_pos_valid?(tickets, index, field, rule_index)
  for ticket in tickets
    return false if not field_valid?(ticket[index], field, rule_index)
  end
  return true
end

fields = rule_index.keys
order = Hash.new
positions = Array(0...fields.length)
while not positions.empty?
  for position in positions
    possible_keys = []
    for field in fields
      possible_keys.push(field) if field_pos_valid?(valid_tickets, position, field, rule_index)
    end
    if possible_keys.length == 1
      fields.delete(possible_keys[0])
      order[possible_keys[0]] = position
      positions.delete(position)
    end
  end
end

product = 1
for field in order.keys
  product = product * my_ticket[order[field]] if field.match?(/departure.*/)
end

print "Part Two: "
p product
