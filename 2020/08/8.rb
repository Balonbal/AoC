lines = File.read("input").split("\n")

def execute(line, acc, instruction_number)
  instruction, argument = line.split(" ")
  next_inst = instruction_number + 1
  p line
  case instruction
    when "nop"
    when "acc"
      acc = acc + argument.to_i
    when "jmp"
      next_inst = instruction_number + argument.to_i
  end
  return [acc, next_inst]
end

def run(program)
  next_instruction = 0
  acc = 0
  lines_performed = []

  while not lines_performed.include?(next_instruction)
    lines_performed.append(next_instruction)
    acc, next_instruction = execute(program[next_instruction], acc, next_instruction)
    break if next_instruction >= program.length
  end

  return [next_instruction, acc]
end

end_line, acc = run(lines)
print "Part one: "
p acc

for i in (0...lines.length)
  program = lines.clone
  inst, arg = program[i].split(" ")
  next if inst == "acc"
  if inst == "nop"
    inst = "jmp"
  else
    inst = "nop"
  end

  program_line= [inst, arg].join(" ")
  program[i] = program_line
  end_line, acc = run(program)
  break if end_line >= lines.length
end

p acc
