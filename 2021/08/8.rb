filename = ARGV[0]

observations = File.read(filename).split("\n").map{|l| l.split(" | ").map{|s| s.split(" ")}}

# Probably setting myself up badly for part B with this...
lengths_to_consider = [2, 3, 4, 7]
puts "Part A:"
p observations.map{|signals, outputs| outputs.select{|o| lengths_to_consider.include?(o.length)}.length}.sum

num_patterns = {
  0 => "abcefg",
  1 => "cf",
  2 => "acdeg",
  3 => "acdfg",
  4 => "bcdf",
  5 => "abdfg",
  6 => "abdefg",
  7 => "acf",
  8 => "abcdefg",
  9 => "abcdfg"
}

sum = 0
observations.each{|signals, outputs|
  translation = Hash.new("")
  # Easy stuff first
  translation[1] = signals.select{|s| s.length == 2}.first
  translation[4] = signals.select{|s| s.length == 4}.first
  translation[7] = signals.select{|s| s.length == 3}.first
  translation[8] = signals.select{|s| s.length == 7}.first
  # 6 has all 5 chars of 5 and one more
  translation[6] = signals.select{|s| s.length == 6 && signals.map{|s1| (s.split("") - s1.split("")).length}.select{|l| l == 5}.length == 1}.first
  # 5 has all but one of 6
  translation[5] = signals.select{|s| s.length == 5 && (translation[6].split("") - s.split("")).length == 1}.first
  # 3 has both chars of 1
  translation[3] = signals.select{|s| s.length == 5 && (s.split("") - translation[1].split("")).length == 3}.first
  # 9 has all chars of both 3 and 4
  translation[9] = signals.select{|s| s.length == 6 && (s.split("") - translation[3].split("") - translation[4].split("")).length == 0}.first
  # 0 is the 6 len which is not 9 or 6
  translation[0] = signals.select{|s| s.length == 6 && s != translation[6] && s != translation[9]}.first
  # Then only 2 remains
  translation[2] = signals.reject{|s| translation.values.include?(s)}.first
  sum += outputs.map{|o| translation.select{|k, v| v.chars.sort == o.chars.sort}.keys}.join.to_i
}

puts "Part B:"
p sum
