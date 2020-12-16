file = File.open("input")
lines = file.readlines.map(&:chomp)
file.close

matches = 0

for line in lines do
  rule, letter, password = line.split(" ")
  first, second = rule.split("-").map(&:to_i)
  letter = letter[0]
  valid = (password[first - 1] == letter) ^ (password[second - 1] == letter)
  if valid
    matches = matches + 1
  end
end

puts matches
