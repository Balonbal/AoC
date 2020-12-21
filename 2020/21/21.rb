input = File.read("input").split("\n")

items = []
item_map = Hash.new
for line in input
  _, ingredient, allergent = line.split /([\w\s]+)\(contains ([\w\s,]+)\)/
  ingredients = ingredient.split " "
  allergies = allergent.split ", "
  for allergent in allergies
    if item_map.key?(allergent)
      list = item_map[allergent]
      list.keep_if{|ingredient| ingredients.include?(ingredient)}
      item_map[allergent] = list
    else
      item_map[allergent] = ingredients.dup
    end
  end
  items.push([ingredients, allergies])
end

allergies_processed = []
loop do
  item = item_map.select{|k, v| not allergies_processed.include?(k) and v.length == 1}
  break if item.empty?
  allergy, ingredient = item.first
  allergies_processed.push(allergy)
  for key, value in item_map
    next if key == allergy
    item_map[key] = value.delete_if{|v| v == ingredient[0]}
  end
end


occurences = 0
for ingredients, allergies in items
  occurences = occurences + ingredients.select{|ingr| not item_map.value?([ingr])}.length 
end
print "Part One: "
p occurences

print "Part Two: "
p item_map.sort.to_h.values.map{|item| item.first}.join(",")
