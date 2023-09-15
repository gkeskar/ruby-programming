def prime?(a)

  (a == 1) ? false:(2...a).none? {|t| a%t==0}

  # return false if num == 1
  # return true if num == 2 or num == 3
  # return false if num % 2 == 0
  # i = 3
  # while ( i < num ) do
  #   return false if num  %  i == 0
  #   i = i + 1
  # end
  # return true
end

puts prime?(3)
puts prime?(17)
puts prime?(22)

puts prime?(13)
puts prime?(21)
puts prime?(9)
puts prime?(17)
puts prime?(29)
puts prime?(63)

