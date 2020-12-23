player1, player2 = File.read("input").split "\n\n"

player1 = player1.split("\n").map(&:to_i)
player2 = player2.split("\n").map(&:to_i)

player1.shift
player2.shift

def play_round(player1, player2)
  card1 = player1.shift
  card2 = player2.shift
  if card1 > card2
    player1.push(card1, card2)
  else
    player2.push(card2, card1)
  end
end

def play_recurse(player1, player2, rec = 0)
  round_tracker = []
  while not player1.empty? and not player2.empty?
    p [player1.length, player2.length] if rec == 0
    return true if round_tracker.include?([player1, player2])
    round_tracker.push([player1.dup, player2.dup])
    card1 = player1.shift
    card2 = player2.shift
    if player1.length >= card1 and player2.length >= card2
      p1 = player1[0...card1].dup
      p2 = player2[0...card2].dup
      winner = play_recurse(p1, p2, rec + 1)
      player1.push(card1, card2) if winner
      player2.push(card2, card1) if not winner
    else
      if card1 > card2
        player1.push(card1, card2)
      else
        player2.push(card2, card1)
      end
    end
  end
  return player2.empty?
end
rec_p1 = player1.dup
rec_p2 = player2.dup
while not player1.empty? and not player2.empty?
  play_round(player1, player2)
end

p1 = player1.reverse.each_with_index.reduce(0){|sum, (el, index)| sum + el * (index+1)}
p2 = player2.reverse.each_with_index.reduce(0){|sum, (el, index)| sum + el * (index+1)}
print "Part One: "
puts [p1, p2].max

winner = play_recurse(rec_p1, rec_p2 )
p1 = rec_p1.reverse.each_with_index.reduce(0){|sum, (el, index)| sum + el * (index+1)}
p2 = rec_p2.reverse.each_with_index.reduce(0){|sum, (el, index)| sum + el * (index+1)}

print "Part Two: "
puts [p1, p2].max
