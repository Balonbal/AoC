filename = ARGV[0]

caves = {}
File.read(filename).split("\n").map{|l| l.split("-")}.each do |f, s| 
  if caves[f].nil?
    caves[f] = [s]
  else
    caves[f] << s
  end
  if caves[s].nil?
    caves[s] = [f]
  else
    caves[s] << f
  end
end

def expand_paths(path, cave_map, max_small)
  paths = []
  for direction in cave_map[path.last]
    .reject{|p| p == "start"}
    .reject{|p| p.downcase == p and path.include?(p) and path.select{|c| c.downcase == c}.tally.has_value?(max_small)}

    new_path = [path + [direction]]
    if direction != "end"
      new_path = expand_paths(new_path.first, cave_map, max_small)
    end
    paths += new_path
  end
  return paths
end

puts "Part A:"
puts expand_paths(["start"], caves, 1).length
puts "Part B: (wait for it)"
puts expand_paths(["start"], caves, 2).length
