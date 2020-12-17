initial = File.read("input").split("\n")
nodes_4d = []

initial.each.with_index { |line, y|
  line.split("").each.with_index { |ch, x|
    nodes_4d.push([x, y, 0, 0]) if ch == "#"
  }
}
def simulate_cycle_4d(nodes, dims = 4)
  result = []
  wrange =  (0..0) if dims == 3
  wrange = (-1..1) if dims == 4
  to_consider = Hash.new(0)
  to_consider[[0, 0, 0, 0]] = 0
  for node in nodes
    x, y, z, w = node
    neighbours = 0
    for dx in (-1..1)
      for dy in (-1..1)
        for dz in (-1..1)
          for dw in wrange
            position = [x + dx, y + dy, z + dz, w + dw]
            next if position == node
            if nodes.include?(position)
              neighbours = neighbours + 1
            else
              to_consider[position] = to_consider[position] + 1
            end
          end
        end
      end
    end
    result.push(node) if [2, 3].include?(neighbours)
  end
  to_consider.each do |position, neighbours|
    result.push(position) if neighbours == 3
  end
  return result.uniq
end

nodes_3d = nodes_4d.dup
for i in (1..6)
  nodes_3d = simulate_cycle_4d(nodes_3d, 3)
  p [i, nodes_3d.length]
end
print "Part One: "
p nodes_3d.length

for i in (1..6)
  nodes_4d = simulate_cycle_4d(nodes_4d, 4)
  p [i, nodes_4d.length]
end
print "Part Two: "
p nodes_4d.length
