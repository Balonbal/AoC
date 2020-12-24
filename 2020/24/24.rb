require 'strscan'
input = File.read("input").split("\n")

# x-> to left y-> down
def translate_from_dir(origin, direction)
  case direction
    when "e"
      return [origin[0] + 2, origin[1]]
    when "se"
      return [origin[0] + 1, origin[1] + 3]
    when "sw"
      return [origin[0] - 1, origin[1] + 3]
    when "w"
      return [origin[0] - 2, origin[1]]
    when "nw"
      return [origin[0] - 1, origin[1] - 3]
    when "ne"
      return [origin[0] + 1, origin[1] - 3]
  end
end

tiles = Hash.new(false)
for line in input
  coord = [0, 0]
  scanner = StringScanner.new(line)
  while dir = scanner.scan(/(e|se|sw|w|nw|ne)/)
    coord = translate_from_dir(coord, dir)
  end
  tiles[coord] = !tiles[coord]
end
tiles.keep_if{|k, v| v}
print "Part One: "
puts tiles.length

directions = ["e", "se", "sw", "w", "nw", "ne"]
for i in (1..100)
  neighbours = Hash.new(0)
  old_tiles = tiles.dup
  #tiles = Hash.new
  for coord, _ in old_tiles 
    active = 0
    for dir in directions
      position = translate_from_dir(coord, dir)
      if old_tiles[position]
        active += 1
      else
        neighbours[position] += 1
      end
    end
    tiles[coord] = false if active > 2 or active == 0
  end
  for coord, _ in neighbours.select{|k, v| v == 2}
    tiles[coord] = true
  end
  tiles.keep_if{|k, v| v}
end

puts "Part Two: %d" % [tiles.length]
