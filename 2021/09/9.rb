filename = ARGV[0]

matrix = File.read(filename).split("\n").map{|line| line.chars.map(&:to_i)}

basins = Hash.new(0)
matrix.each_with_index do |row, y|
  row.each_with_index do |number, x|
    next if number == 9

    next_point = [x, y]
    while next_point do
      my_x, my_y = next_point
      next_point = [[0,1],[1,0],[-1,0],[0,-1]].map{|dx, dy| [my_x + dx, my_y + dy]}
        .reject{|px,py| py < 0 or px < 0 or matrix[py] == nil or matrix[py][px] == nil}
        .select{|px,py| matrix[py][px] < matrix[my_y][my_x]}
        .first
    end
    basins[[my_x, my_y]] += 1
  end
end

puts "Part A:"
p basins.keys.map{|x, y| matrix[y][x] + 1}.sum

puts "Part B:"
p basins.values.sort.reverse[0...3].reduce(:*)
