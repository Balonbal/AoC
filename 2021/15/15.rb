filename = ARGV[0]
cave = File.read(filename).split("\n").map{|p| p.chars.map(&:to_i)}

def navigate_to(cave, from, to)
  risks = Hash.new(1000000)
  risks[from] = 0
  to_visit = [from]
  while not to_visit.empty?
    (x, y) = to_visit.sort_by!{|(x,y)| -risks[[x,y]]}.pop
  
    return risks[[x,y]] if [x,y] == to

    [[1,0], [0,1], [-1,0], [0,-1]].map{|dx, dy| [x + dx, y + dy]}
      .reject{|px, py| px < 0 or py < 0 or cave[py].nil? or cave[py][px].nil?}
      .each do |px, py|
      my_risk = risks[[x,y]] + cave[py][px]
      next if my_risk > risks[[px,py]]
        
      risks[[px,py]] = my_risk
      to_visit.push([px,py]) if not to_visit.include?([px,py])
    end
  end
end

puts "Part A*:"
p navigate_to(cave, [0,0], [cave[0].length - 1, cave.length - 1])

large_cave = []
height = cave.length
width = cave[0].length
for dy in (0...5)
  for y in (0...height)
    tunnel = []
    for dx in (0...5)
      for x in (0...width)
        v = (cave[y][x] + dx + dy)
        v -= 9 if v > 9
        tunnel.push v
      end
    end
    large_cave.push tunnel
  end
end
puts "Part B:"
puts "Wait for it......."
p navigate_to(large_cave, [0,0], [5*width - 1, 5*height - 1])
