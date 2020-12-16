file = File.open("input")

numbers = file.readlines.map(&:chomp).map(&:to_i)

file.close

while not numbers.empty?
  num_a = numbers.pop
  for num_b in numbers do
    for num_c in numbers.reject{|candidate| candidate == num_b} do
      if num_a + num_b + num_c == 2020
        puts num_a * num_b * num_c
      end
    end
  end
end
