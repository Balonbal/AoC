groups = File.read("input").split("\n\n")

group_ans = groups.map{|group| group.delete("\n").split("").uniq}

print "Part one: "
puts group_ans.map{|group| group.length}.reduce(:+)

for i in (0..groups.length)
  for person in groups[i].to_s.split("\n")
    group_ans[i].delete_if{|ans| not person.include?(ans)}
  end
end

print "Part two: "
puts group_ans.map{|group| group.length}.reduce(:+)

