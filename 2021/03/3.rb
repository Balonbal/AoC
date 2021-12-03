filename = ARGV[0]
lines = File.read(filename).split("\n")
bits = lines.map{|l| l.split("")}.transpose
# Gamma = not epsilon
gamma_n_epsilon = bits.map{|l| l.count("1") > l.length/2 ? "1" : "0"}.join("")

puts "Part A:"
# Ugly hack to invert only the specified bits
puts gamma_n_epsilon.to_i(2) *(~gamma_n_epsilon.to_i(2) & ((1 << lines[0].length) - 1))

bits_o2 = bits.transpose
bits_co2 = bits.transpose

(0..bits.length).each{|i|
  if bits_o2.length > 1
    to_reject = bits_o2.transpose[i].count("1") >= bits_o2.length / 2.0 ? "1" : "0"
    bits_o2.reject!{|l| l[i] != to_reject}
  end

  if bits_co2.length > 1
    to_reject = bits_co2.transpose[i].count("1") < bits_co2.length / 2.0 ? "1" : "0"
    bits_co2.reject!{|l| l[i] != to_reject}
  end
}

puts "Part B:"
p [bits_o2, bits_co2].map{|bits| bits.join("").to_i(2)}.reduce(1, :*)
