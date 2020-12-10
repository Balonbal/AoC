numbers = File.read("input").split("\n").map(&:to_i)

def valid?(preamble, number)
  while not preamble.empty?
    num_a = preamble.pop
    for num_b in preamble
      if num_a != num_b and num_a + num_b == number
        return true
      end
    end
  end
  return false
end

weakness = 0
preamble = numbers[0..24]
for i in numbers[25..-1]
  if not valid?(preamble.clone, i)
    weakness = i
    break
  end
  preamble.shift
  preamble.push(i)
end

print "Part One: "
p weakness

preamble = []
while not numbers.empty?
  preamble.push(numbers.shift)
  total = preamble.reduce(:+)

  p preamble 
  while total > weakness 
    total = total - preamble.shift
  end
  break if total == weakness
end

print "Part two: "
p preamble.min + preamble.max
