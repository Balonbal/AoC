arrival, busses = File.read("input").split("\n")

arrival = arrival.to_i
buslist = busses.split(",").map(&:to_i).reject{|time| time == 0}
buslist.map!{|time| [time, (time * (arrival/time + 1).ceil - arrival)]}
bestBus, bestTime =  buslist.min{|a, b| a[1] <=> b[1]}

print "Part One: "
p bestBus * bestTime

departures = busses.split(",").map(&:to_i)
eqSystem = []
for i in (0...departures.length)
  eqSystem.push([departures[i], i]) if departures[i] != 0
end

departure = 0
advancement = 1
for bus, mod in eqSystem
  p [bus, mod]
  loop do
    break if (departure + mod)% bus == 0
    departure = departure + advancement
  end
  advancement = advancement * bus
  p [bus, departure]
end

print "Part Two: "
p departure

