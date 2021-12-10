filename = ARGV[0]
lines = File.read(filename).split("\n")

score_map = {
  ")" => 3,
  "]" => 57,
  "}" => 1197,
  ">" => 25137
}

autocomplete_map = {
  "(" => 1,
  "[" => 2,
  "{" => 3,
  "<" => 4
}

sum = 0
autocomplete = []
for line in lines
  loop do
    old_line = line.dup
    line.gsub!(/(\[\]|\(\)|\{\}|\<\>)/, "")
    break if line == old_line 
  end
  strindex = line.index(/(\)|\]|\}|\>)/)
  sum += score_map[line[strindex]] if strindex
  if not strindex
    autocomplete.append(line.reverse.chars.reduce(0){|acc, c| acc * 5 + autocomplete_map[c]})
  end
end

puts "Part A:"
p sum

puts "Part B:"
p autocomplete.sort[autocomplete.length / 2]
