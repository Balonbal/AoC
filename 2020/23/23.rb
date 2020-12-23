input = "463528179"
cups = input.split("").map(&:to_i)

def do_moves(first, cup_map, moves)
  current = first
  total_cups = cup_map.values.max
  for i in (1...moves)
    removed = []
    for j in (0...3)
      value = cup_map[current]
      removed.push value
      cup_map[current] = cup_map[value]
    end
    destination = current - 1
    destination = total_cups if current == 1
    while removed.include? destination
      destination -= 1
      destination = total_cups if destination == 0
    end

    cup_map[removed.last] = cup_map[destination]
    cup_map[removed[1]] = removed.last
    cup_map[removed.first] = removed[1]
    cup_map[destination] = removed.first
    current = cup_map[current]
  end
end

cup_map = Hash.new
cups = input.split("").map(&:to_i)
for index in (0...cups.length-1)
  cup_map[cups[index]] = cups[index + 1] 
end
cup_map[cups.last] = cups.first

do_moves(cups.first, cup_map, 101)
str = ""
curr = 1
while cup_map[curr] != 1
  curr = cup_map[curr]
  str += curr.to_s
end
print "Part One: "
puts str

cup_map = Hash.new
for index in (0...cups.length-1)
  cup_map[cups[index]] = cups[index + 1] 
end
total_cups = 1e6
for i in ((cups.max + 1)...total_cups)
  cup_map[i] = i+1
end

cup_map[total_cups.to_i] = cups.first
cup_map[cups.last] = cups.max + 1
current = cups.first

do_moves(cups.first, cup_map, 1e7)
print "Part Two: "
puts cup_map[1] * cup_map[cup_map[1]]
