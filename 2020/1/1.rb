file = File.open("input")

numbers = file.readlines.map(&:chomp).map(&:to_i)

file.close

while not numbers.empty?
  num_a = numbers.pop
  for num_b in numbers do
#    puts num_a + num_b
    if num_a + num_b == 2020
      puts num_a * num_b
    end
  end
end
