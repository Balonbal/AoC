file = File.open("input")
lines = file.readlines.map(&:chomp)
file.close

matches = 0

for line in lines do
  rule, letter, password = line.split(" ")
  min, max = rule.split("-").map(&:to_i)
  letter = letter[0]
  count = password.count(letter)
  if count >= min and count <= max
    matches = matches + 1
  end
end

puts matches
