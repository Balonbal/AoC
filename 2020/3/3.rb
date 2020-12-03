file = File.open("input")
lines = file.readlines.map(&:chomp)
file.close

def tree_traverser(map, right, down)
  trees = 0
  xcoord = 0

  for index in (0..map.length).step(down)
    position = map[index].to_s[xcoord]
    if position == "#"
      trees = trees + 1
    end
    xcoord = (xcoord + right) % map[0].length
  end
  return trees
end

print "Part one: "
puts tree_traverser(lines, 3, 1)
print "Part two: "
puts [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]].map { 
 |movement| tree_traverser(lines, movement[0], movement[1])
}.reduce(1, :*)
