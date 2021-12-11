filename = ARGV[0]
octopuses = File.read(filename).split("\n").map{|o| o.chars.map(&:to_i)}

def flash(octopuses, row, col)
  flashes = 1
  [-1, 0, 1].product([-1, 0, 1])
    .reject{|dr, dc| dr == 0 and dc == 0}
    .map{|dr, dc| [row + dr, col + dc]}
    .reject{|r, c| r < 0 or c < 0 or octopuses[r] == nil or octopuses[r][c] == nil}
    .each do |r, c|
      octopuses[r][c] += 1
      if octopuses[r][c] == 10
        flashes += flash(octopuses, r, c)
      end
  end
  return flashes
end

flashes = 0
days = 0
loop do
  days += 1
  octopuses.each_with_index do |octopus_row, row|
    octopus_row.each_with_index do |octopus, col|
      octopuses[row][col] += 1
      if octopuses[row][col] == 10
        flashes += flash(octopuses, row, col)
      end
    end
  end

  octopuses.map!{|r| r.map{|o| o > 9 ? 0 : o}}

  puts "Part A: #{flashes}" if days == 100 
  break if octopuses.map{|r| r.sum}.sum == 0
end

puts "Part B: #{days}"
