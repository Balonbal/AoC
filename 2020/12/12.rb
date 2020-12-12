instructions = File.read("input").split("\n")

instructions.map!{|ins| [ins[0], ins[1..-1].to_i]}

def move(cmd, dist)
  case cmd
  when "N"
    return [0, dist]
  when "S"
    return [0, -dist]
  when "E"
    return [dist, 0]
  when "W"
    return [-dist, 0]
  end
end


def navigate(commands)
  facing = "E"
  facings = ["E", "S", "W", "N"]
  x = 0
  y = 0
  for cmd, dist in commands
    if ["L", "R"].include?(cmd)
      dist = -dist if cmd == "L"
      facing = facings[(facings.index(facing) + dist / 90) % facings.length]
    else
      cmd = facing if cmd == "F"
      dx, dy = move(cmd, dist)
      x = x + dx
      y = y + dy
    end
  end
  return [x, y]
end

def navigate_waypoint(commands)
  ship = [0, 0]
  waypoint = [10, 1]
  for cmd, dist in commands
    if ["L", "R"].include?(cmd)
      for i in (0...dist/90)
        east = waypoint[1]
        east = -east if cmd =="L"
        north = -waypoint[0]
        north = -north if cmd =="L"
        waypoint = [east, north]
      end
    elsif cmd == "F"
      ship = [ship[0] + dist * waypoint[0], ship[1] + dist * waypoint[1]]
    else
      dx, dy = move(cmd, dist)
      waypoint = [waypoint[0] + dx, waypoint[1] + dy]
    end
  end
  return ship
end

x, y = navigate(instructions)
print "Part One: "
p x.abs + y.abs


x, y = navigate_waypoint(instructions)
print "Part Two: "
p x.abs + y.abs
