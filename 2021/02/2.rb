filename = ARGV[0]
lines = File.read(filename).split("\n")
directions = lines.map{|l| l.split(" ")}.collect{ |(direction, distance)|
  if direction == "up"
    [0, -distance.to_i]
  elsif direction == "down"
    [0, distance.to_i]
  elsif direction == "forward"
    [distance.to_i, 0]
  end
}

puts "Part A:"
puts directions.reduce([0,0]){|(position,depth),(horiz,vert)| 
  [position + horiz, depth + vert]
}.reduce(1, :*)

puts "Part B:"
puts directions.reduce([0,0,0]){|(position,depth,aim),(horiz,vert)|
  [position + horiz, depth + aim * horiz, aim + vert]
}.slice(0,2).reduce(1, :*)
