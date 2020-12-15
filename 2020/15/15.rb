# Woah not a file?
input = [0, 8, 15, 2, 12, 1, 4]
n_hash = Hash.new(-1)

prev_index = -1
for i in (0...input.length)
  n_hash[input[i]] = i
end

for i in (input.length...30000000)
  number = i - prev_index - 1
  number = 0 if prev_index == -1
  prev_index = n_hash[number]
  n_hash[number] = i
  if i + 1 == 2020
    print "Part One: "
    p number
  end
end

print "Part Two: "
p number 
