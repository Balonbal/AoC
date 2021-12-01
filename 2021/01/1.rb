filename = ARGV[0]
numbers = File.read(filename).split("\n").map(&:to_i)

puts "Part A:"
puts numbers.each_cons(2).map{|(a,b)| (a < b) ? 1 : 0}.sum

puts "Part B:"
sums = numbers.each_cons(3).map{|nums| nums.sum}
puts sums.each_cons(2).map{|(a, b)| (a < b) ? 1 : 0}.sum
