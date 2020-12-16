passports = File.read("input").split("\n\n")

required = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
optional = ["cid"]

present = 0
valid = 0

def invalid?(key, value_s)
  value = value_s.to_i
  case key
  when "byr"
    return (value < 1920 or value > 2002)
  when "iyr"
    return (value < 2010 or value > 2020)
  when "eyr"
    return (value < 2020 or value > 2030)
  when "hgt"
    if value_s.include?("in")
      return (value < 59 or value > 76)
    else
      return (value < 150 or value > 193)
    end
  when "hcl"
    return (not value_s.match?(/#[0-9a-f]{6}/))
  when "ecl"
    return (not ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].include?(value_s))
  when "pid"
    return (not value_s.match?(/^[0-9]{9}$/))
  when "cid"
    return false 
  end
end

for passport in passports
  kv_pairs = passport.split(/ |\n/)
  remainding_keys = required.clone
  field_check = true
  for kv in kv_pairs
    key, value = kv.split(":")
    remainding_keys = remainding_keys.reject{|k| k == key}
    p [key, value, invalid?(key, value)]
    field_check = field_check & (not invalid?(key, value) )
  end
  if remainding_keys.length == 0
    present = present + 1
    if field_check
      valid = valid + 1
    end
  end
end

puts present
puts valid
