tickets = File.read("input").split("\n")

def binary_search(range, input, keep_top)
  for c in input.split("")
    if c == keep_top
      range.keep_if{|data| data > range.last - range.length / 2}
    else
      range.keep_if{|data| data < range.last + 1 - range.length / 2}
    end
  end
  return range[0]
end

def ticket_pos(line)
  row = binary_search(Array(0..127), line[0..6], "B")
  column = binary_search(Array(0..7), line[7..9], "R")

  return row, column
end

possible_seats = Array(0..(127 * 8))
max = 0
min = 127*8
for ticket in tickets
  row, column = ticket_pos(ticket)
  value = row * 8 + column
  possible_seats.delete_if{|seat| seat == value}
  if value > max
    max = value
  elsif value < min
    min = value
  end
end

possible_seats.delete_if{|seat| seat < min or seat > max}

print "Part one"
puts max
print "Part two"
p possible_seats
