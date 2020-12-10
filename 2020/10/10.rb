numbers = File.read("input").split("\n").map(&:to_i)

numbers.unshift(0)
numbers.push(numbers.max + 3)
numbers.sort!

differences = numbers.map.with_index{ |num, idx| 
  idx == numbers.length - 1 ? 0 : numbers[idx+1] - num
}
differences.pop

print "Part One: "
p differences.select{|num| num == 3}.length * differences.select{|num| num == 1}.length


def possible_shuffles(size)
  case size
  when 0 
    return 1
  when 1 
    return 1
  when 2 
    return 2
  when 3 
    return 4
  when 4 
    return 7 # 2^3 - 1
  when 5 
    return 13 # 2 ^ 4 - 3
  end
end

ways = 1
group_size = 0
for diff in differences
  if diff == 1
    group_size = group_size + 1
  else
    ways = ways * possible_shuffles(group_size)
    group_size = 0
  end
end
p ways
