filename = ARGV[0]

lines, instructions = File.read(filename).split("\n\n").map{|s| s.split("\n")}
lines.map!{|l| l.split(",").map(&:to_i)}
instructions.map!{|i| i.sub("fold along ", "").split("=")}.map!{|(f, s)| [f, s.to_i]}

def print_lines(lines)
  for y in (0..lines.map{|x,y| y}.max)
    for x in (0..lines.map{|x,y| x}.max)
      if lines.include?([x,y])
        print "#"
      else
        print "."
      end
    end
    print "\n"
  end
end

instructions.each_with_index do |(direction, coord), index|
  puts "Part A: #{lines.count}" if index == 1
  lines.map!{|x,y| x > coord ? [-x + 2*coord, y] : [x, y]}.uniq! if direction == "x"
  lines.map!{|x,y| y > coord ? [x, -y + 2*coord] : [x, y]}.uniq! if direction == "y"
end

puts "Part B:"
print_lines(lines)
