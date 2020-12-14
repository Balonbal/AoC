instructions = File.read("input").split("\n")
def construct_addrs(mask, addr)
  addrs = [addr.to_s(2).rjust(36, "0")]
  mask_or  = (mask.gsub("X", "0")).to_i(2)
  next_addr = []
  while (index = mask.index("X")) != nil
    next_addr = []
    for a in addrs
      a[index] = "0"
      next_addr.push(a.dup)
      a[index] = "1"
      next_addr.push(a)
    end
    addrs = next_addr.dup
    mask[index] = "0"
  end
  return addrs.map{|a| a.to_i(2) | mask_or}
end

mask_and = 0
mask_or  = 0
mask = ""
memory = Hash.new
memory2 = Hash.new

for instruction in instructions
  cmd, param = instruction.split(" = ")
  if cmd == "mask"
    mask_and = (param.gsub("X", "1")).to_i(2)
    mask_or  = (param.gsub("X", "0")).to_i(2)
    mask = param
  else
    value = (param.to_i & mask_and) | mask_or
    addr = cmd.gsub(/[^\d]/, "").to_i
    memory[addr] = value
    for addr in construct_addrs(mask.dup, addr)
      memory2[addr] = param.to_i
    end
  end
end

print "Part One: "
p memory.values.reduce(:+)
print "Part Two: "
p memory2.values.reduce(:+)
