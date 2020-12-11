seats = File.read("input").split("\n")

def check_seat(list, row, col)
  occupied = 0
  for dr in (-1..1)
    next if row + dr < 0 or row + dr >= list.length
    col_min = col - 1
    col_min = 0 if col == 0 
    occupied = occupied + list[row + dr][col_min..col+1].split("").select{|s| s == "#"}.count
  end
  return occupied
end

def check_first(list, row, col)
  occupied = 0
  for dy in (-1..1)
    for dx in (-1..1)
      next if dy == 0 and dx == 0
      r = 1
      loop do
        break if row + r*dy < 0 or row + r*dy >= list.length
        break if col + r*dx < 0 or col + r*dx >= list[0].length
        occupied = occupied + 1 if list[row + r*dy][col + r*dx] == "#"
        break if list[row + r*dy][col + r*dx] != "."
        r = r + 1
      end
    end
  end
  return occupied
end

def simulate(list, check_algo)
  res = list.dup.map(&:dup)
  for row_idx in (0...list.length)
    row = list[row_idx]
    for col_idx in (0..row.length)
      if (row[col_idx] == "#" and check_algo.call(list, row_idx, col_idx) > 4)
        res[row_idx][col_idx] = "L"
      elsif (row[col_idx] == "L" and check_algo.call(list, row_idx, col_idx) == 0)
        res[row_idx][col_idx] = "#"
      end
    end
  end
  return res
end

seats1 = seats
loop do
  new_list = simulate(seats1, method(:check_seat))
  break if new_list == seats1
  seats1 = new_list
end

print "Part One: "
p seats1.map{|row| row.split("").select{|col| col == "#"}.count}.reduce(:+)

loop do
  new_list = simulate(seats, method(:check_first))
  break if new_list == seats
  seats = new_list
end

print "Part Two: "
p seats.map{|row| row.split("").select{|col| col == "#"}.count}.reduce(:+)

