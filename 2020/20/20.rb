blocks = File.read("input").split("\n\n")
monster = File.read("monster").split("\n")
tiles = Hash.new

for block in blocks
  lines = block.split("\n")
  id = lines.shift.scan(/\d+/)[0].to_i
  tiles[id] = lines
end

def get_borders(tile)
  left = ""
  right = ""
  for line in tile
    left = left + line.split("").first
    right = right + line.split("").last
  end
  return [tile.first, right, tile.last.reverse, left]
end

def find_bordering_tiles(my_tile, tiles)
  my_borders = get_borders(my_tile[1])
  neighbours = []
  my_borders.each.with_index do |border, idx|
    for id, tile in tiles
      next if id == my_tile[0]
      borders = get_borders(tile)
      neighbours.push([id, idx]) if borders.include?(border)
      neighbours.push([id, idx]) if borders.include?(border.reverse)
    end
  end
  return neighbours
end

def rotate_block(block, rotation)
  for _ in (0...rotation)
    new_block = []
    for y in (0...block.length)
      line = ""
      for x in (0...block.length)
        line = line + block[x][y]
      end
      new_block.push(line.reverse)
    end
    block = new_block
  end
  return block
end

def check_left_top(block, left, top)
  borders = get_borders(block)
  return false if left != "" and borders[3]!= left
  return false if top  != "" and borders[0].reverse != top
  return true
end 

def get_permutations(block)
  for tile in [block, block.reverse]
    for i in (0..3)
      yield  rotate_block(tile, i)
    end
  end
end

def get_fit_left_top(tile, position, image)
  left = ""
  top = ""
  left = get_borders(image[[position[0] - 1, position[1]]])[1] if position[0] > 0
  top = get_borders(image[[position[0], position[1] - 1]])[2] if position[1] > 0
  get_permutations(tile) do |block|
    return block if check_left_top(block, left, top)
  end
  return false
end

puts "Finding corners"
corners = []
for id, block in tiles
  tile = [id, block]
  neighbours = find_bordering_tiles(tile, tiles)
  corners.push([id, neighbours]) if neighbours.length == 2
end
print "Part One: "
puts corners.map{|corner| corner[0]}.reduce(1, :*)

puts "Constructing map...."
image = Hash.new
image_size = Math.sqrt(tiles.length)

# orient and put down first corner
corner = corners.first
corners = [corner[1][0][1], corner[1][1][1]].sort
# neighbours on left, bottom = no rotation, top, right = 1 rotation.. etc
rotations = [[1, 2], [0, 1], [0, 3], [2, 3]]
block = rotate_block(tiles[corner[0]], rotations.index(corners))
block = rotate_block(block.reverse, 1)

def fill_position(block, id, position, image, image_size, remainding_tiles)
  image[position] = block
  remainding_tiles.delete(id)
  return true if remainding_tiles.empty?
  x, y = position
  x = x + 1
  if x == image_size
    x = 0
    y = y + 1
  end
  for id, tile in remainding_tiles
    tile = get_fit_left_top(tile, [x, y], image)
    if tile != false
      if fill_position(tile, id, [x, y], image, image_size, remainding_tiles.dup)
        return true
      end
    end
  end
  return false
end

fill_position(block, corner[0], [0, 0], image, image_size, tiles)
lines = []

for y in (0...image_size)
  for linepos in (1...block.length-1)
    line = ""
    for x in (0...image_size)
      line = line + image[[x, y]][linepos][1..-2] if image[[x, y]] != nil
    end
    lines.push(line)
  end
end

puts "Found map:"
puts lines

def check_monster_line(lines, line, pos, monster)
  for i in (0..2)
    for offset in (0...monster[0].length)
      return false if monster[i][offset] == "#" and lines[line + i][pos + offset] != "#"
    end
  end
  for i in (0..2)
    for offset in (0...monster[0].length)
      lines[line + i][pos + offset] = "O" if monster[i][offset] == "#"
    end
  end
  return true
end

monsters = 0
monster_size = monster.join("").count("#")
get_permutations(lines) do |map|
  monsters = 0
  for i in (0...map.length-3)
    for pos in (0...map[0].length - monster[0].length)
      monsters = monsters + monster_size if check_monster_line(map, i, pos, monster)
    end
  end
  puts map if monsters != 0 
  #break if monsters != 0
end
print "Part Two: "
puts lines.join("").count("#") - monsters
