from_file, to_file = ARGV
File.open(to_file, 'w').write(File.open(from_file).read)

puts "Allright, all done"

