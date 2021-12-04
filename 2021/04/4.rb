filename = ARGV[0]
lines = File.read(filename).split("\n\n")

numbers = lines[0].split(",").map(&:to_i)
boards = lines[1..-1].map{|b| b.split("\n").map{|l| l.split(" ").map(&:to_i)}}
all_boards = boards + boards.map{|b| b.transpose}

def find_winner(numbers, all_boards)
  for num in numbers[0..-1]
    all_boards.each{|b| 
      b.each{|line| line.delete(num)}
      if b.map{|l| l.length}.min == 0
        return [num, b]
      end
    }
  end
end

puts "Part A:"
number, board = find_winner(numbers, all_boards)
p number * board.reduce(0){|acc, x| acc + x.sum}

def find_loser(numbers, all_boards)
  for num in numbers[0..-1]
    winners = []
    all_boards.each_with_index{|b, i|
      b.each{|line| line.delete(num)}
      if b.map{|l| l.length}.min == 0
        # Winner and the transpose
        winners.append(i)
        winners.append((i + all_boards.length/2).modulo(all_boards.length))
      end
    }
    if winners.length > 0
      if all_boards.length == 2
        return [num, all_boards[0]]
      else
        # Delete numbers from the end such that idencies are still valid
        winners.uniq.sort.reverse.each{|i| all_boards.delete_at(i)}
      end
    end
  end
end

puts "Part B:"
number, board = find_loser(numbers, all_boards)
p number * board.reduce(0){|acc, x| acc + x.sum}

