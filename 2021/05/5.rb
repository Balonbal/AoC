filename = ARGV[0]
pipes = File.read(filename).split("\n").map{|p| p.split(" -> ").map{|s| s.split(",").map(&:to_i)}}

straight_pipes = pipes.reject{|p| p[0][0] != p[1][0] && p[0][1] != p[1][1]}

overlaps = Hash.new(0)
straight_pipes.each{|pipe|
  xmin = [pipe[0][0], pipe[1][0]].min
  xmax = [pipe[0][0], pipe[1][0]].max
  ymin = [pipe[0][1], pipe[1][1]].min
  ymax = [pipe[0][1], pipe[1][1]].max
  for x in (xmin..xmax)
    for y in (ymin..ymax)
      overlaps[[x, y]] += 1
    end
  end
}

puts "Part A:"
p overlaps.select{|k, v| v > 1}.length

(pipes - straight_pipes).each{|pipe|
  dx = pipe[0][0] < pipe[1][0] ? 1 : -1
  dy = pipe[0][1] < pipe[1][1] ? 1 : -1

  for l in (0..(pipe[1][0] - pipe[0][0]).abs)
    overlaps[[pipe[0][0] + dx * l, pipe[0][1] + dy * l]] += 1
  end
}

puts "Part B:"
p overlaps.select{|k, v| v > 1}.length
