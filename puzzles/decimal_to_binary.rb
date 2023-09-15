
def decimal_to_binary(num)

  if num == 0 then 0 end
  output = ""

  while (num != 0) do
    output = num % 2 + output
    num = num / 2
  end

end

puts decimal_to_binary(42)