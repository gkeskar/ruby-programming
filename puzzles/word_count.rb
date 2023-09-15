require 'byebug'
words = File.read('file.txt').downcase.scan(/\b[\w']+\b/)

result = Hash.new(0)

words.each do |word|
  result[word] += 1
end
# sort_by :sorts hash by values
# reverse for descending order
# map to swap key and values
# first{10} to get first 10 elements
# last each loop to print out results
result.sort_by { |k,v| v}.reverse.map{ |m| m.reverse}.first(10).each { |k, v| puts "#{k} #{v}" }

