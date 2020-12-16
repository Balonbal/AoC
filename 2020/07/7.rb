file = File.open("input")
rules = file.readlines.map(&:chomp)
file.close

rules.map!{|rule| rule.split(/ contains? /)}
answers = []
containing_bags = ["shiny gold bag"]
loop do
  containing_bags = rules.select{ |rule| 
    containing_bags.any? { |bag|
      rule[1].include?(bag)}}
        .map{|rule| rule[0].delete_suffix("s")}
  answers = answers + containing_bags
  break if containing_bags.length == 0
end

print "Part One: "
p answers.uniq.length

answer = 0
unpacked_bags = ["shiny gold bag"]
rules.map!{|rule| [rule[0], rule[1].split(", ")]}
def bag_count?(bag, list)
  bags = 0
  recepie = list.select{|rule| rule[0].include? bag}[0]
  p recepie
  if recepie[1] == ["no other bags."]
    return 0
  end
  for ingredient in recepie[1]
    bag = ingredient.gsub(/^\d\s(.+)/, '\1').delete_suffix(".").delete_suffix("s")
    number = ingredient.to_i
    p [number, bag]
    bags = bags + number * (bag_count?(bag, list) + 1)
  end

  return bags
end
 
p bag_count?("shiny gold bag", rules)





