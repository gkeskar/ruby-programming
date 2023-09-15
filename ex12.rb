print "Give me a number: "
number = gets.chomp.to_f

ten_percent = '%.2f' % (number * 0.10)

puts "10% of number is #{ten_percent}"
