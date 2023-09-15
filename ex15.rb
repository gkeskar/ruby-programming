filename = ARGV.first

txt = open(filename)

puts "Here's your file #{filename}:"
print txt.read
txt.close()


txt_again = open(filename)
print txt_again.read
txt_again.close()