filename = ARGV[0]

template, rules = File.read(filename).split("\n\n")

rules = rules.split("\n").map{|r| r.split(" -> ")}
rulemap = Hash.new("")
pairs = Hash.new(0)
rules.each{|cond, res| rulemap[cond.chars] = res}
template.chars.each_cons(2){|t1, t2| pairs[[t1, t2]] += 1}

for i in (0...40)
  result = Hash.new(0)
  pairs.each do |(k1, k2),v|
    c = rulemap[[k1, k2]]
    if c != ""
      result[[k1, c]] += v
      result[[c, k2]] += v
    else
      result[[k1, k2]] += v
    end
  end
  pairs = result
  # oh god what happened here
  if i == 9 or i == 39
    puts "Part A:" if i == 9
    puts "Part B:" if i == 39
    charmap = Hash.new(0)
    # each char will be counted twice
    pairs.each{|(k1, k2), v| charmap[k1] += v/2.0; charmap[k2] += v/2.0}
    # ... except the first and last chars are only counted once
    charmap[template[0]] += 0.5
    charmap[template[-1]] += 0.5

    counts = charmap.values
    p (counts.max - counts.min).to_i
  end
end

