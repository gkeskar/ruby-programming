
input = "The fourth line.\nThe fifth line."

lines = input.split("\n")
puts lines

# inner loop count is array size
i = 0
puts i
output = ""
j = 0

while i < lines.size

  output = lines[i].chars[j]
  i = i + 1
end





# puts output