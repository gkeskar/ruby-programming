begin
  result  = 10/0
  puts result
rescue ZeroDivisionError => e
  # puts "Exception class: #{ e.class.name }"
  puts "Division by zero is not allowed."
end