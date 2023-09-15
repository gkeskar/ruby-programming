def compress(input_s)
  array = input_s.chars
  output = ""
  count = 0
  (array.length).times do |i|

    if array[i] == array[i+1] && i != array.length
      count += 1
    else
      output = output+"#{array[i]}#{count+1}"
      i = count + 1
      count = 0
    end
  end
  output
end

def decompress (input_s)
  output = ""
  array = input_s.chars
  (array.length).times do |i|
    t = array[i +1].to_i
    output = output + array[i]*t
    i = i + 1
  end
  output
end

puts compress("WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB")
puts decompress("a3b4c3")