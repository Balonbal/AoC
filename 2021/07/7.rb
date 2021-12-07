filename = ARGV[0]

crabs = File.read(filename).split(",").map(&:to_i)

puts "Part A:"
p crabs.map{|pos| crabs.map{|crab| (crab - pos).abs}.sum}.min

puts "Part B:"
p (crabs.min..crabs.max).map{|pos| crabs.map{|crab| (1..(crab - pos).abs).sum}.sum}.min
