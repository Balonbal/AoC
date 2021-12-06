filename = ARGV[0]
fish = File.read(filename).split(",").map(&:to_i)

fish_counts = (0..8).map{|i| fish.select{|f| f == i}.length}

def count_fishes(fish_counts, days)
  for i in (1..days)
    fish_counts[7] += fish_counts[0]
    fish_counts.rotate!(1)
  end
  return fish_counts
end

puts "Part A:"
puts count_fishes(fish_counts.dup, 80).sum

puts "Part B:"
puts count_fishes(fish_counts.dup, 256).sum
