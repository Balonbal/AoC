filename = ARGV[0]
commands = File.read(filename).split("\n").map{|l| l.chars.map{|c| "%04b" % c.to_i(16)}.join}

vsum = 0


def parse_literal(packet)
  literals = []
  loop do
    num, packet = packet.slice!(0...5), packet
    literals << num.slice(1...5)
    break if num[0] == "0"
  end  
  return literals.join.to_i(2), packet
end

def parse_packet(packet)
  info = {}
  info["version"], packet = packet.slice!(0...3).to_i(2), packet
  info["type"], packet = packet.slice!(0...3).to_i(2), packet
  if info["type"] == 4
    info["payload"], packet = parse_literal(packet)
  else
    info["len_type"], packet = packet.slice!(0...1).to_i(2), packet
    info["payload"] = []
    if info["len_type"] == 1
      info["num_packets"], packet = packet.slice!(0...11).to_i(2), packet
      remainder = packet.dup
      while info["payload"].length < info["num_packets"] and remainder.length > 0
        pck, remainder = parse_packet(remainder)
        info["payload"] << pck
      end
    else
      info["length"], packet = packet.slice!(0...15).to_i(2), packet
      remainder = packet.dup
      while packet.length - remainder.length < info["length"] and remainder.length > 0
        pck, remainder = parse_packet(remainder)
        info["payload"] << pck
      end
    end
    packet = remainder
  end

  return [info, packet]
end

def version_sum(packet)
  my_sum = packet["version"]
  if packet["type"] != 4
    for pck in packet["payload"]
      my_sum += version_sum(pck)
    end
  end
  return my_sum
end

def compute_packet(packet)
  return packet["payload"] if packet["type"] == 4

  values = packet["payload"].map{|pck| compute_packet(pck)}
  case packet["type"]
  when 0
    return values.sum
  when 1
    return values.reduce(1, :*)
  when 2
    return values.min
  when 3
    return values.max
  when 5
    return values[0] > values[1] ? 1 : 0
  when 6
    return values[0] < values[1] ? 1 : 0
  when 7
    return values[0] == values[1] ? 1 : 0
  end
end

for command in commands
  packet, _ = parse_packet(command)
  puts "Part A: #{version_sum(packet)}"
  puts "Part B: #{compute_packet(packet)}"
end

