
require 'byebug'



# def map_index(c)
#   arr = ('a'..'z').to_a
#   arr_2 = ('A'..'Z').to_a
#   if arr.include?(c)
#     index = arr.find_index(c)
#   else  arr_2.include?(c)
#     index = arr_2.find_index(c)
#   end
#   if (index + 13) > 26
#     new_index = (index + 13) - 26
#   else
#     new_index = index + 13
#   end
#   new_index
# end
#
# def replace_char(c)
#   puts "c : #{c}"
#   arr = ('a'..'z').to_a
#   arr_2 = ('A'..'Z').to_a
#
#
#   map_idx = index(c)
#
#
#   if arr.include?(c)
#     index = arr.find_index(c)
#     if (index + 13) > 26
#       new_index = (index + 13) - 26
#     else
#       new_index = index + 13
#     end
#     new_c = arr[new_index]
#
#   elsif  arr_2.include?(c)
#     index = arr_2.find_index(c)
#     if (index + 13) > 26
#       new_index = (index + 13) - 26
#     else
#       new_index = index + 13
#     end
#     new_c = arr_2[new_index]
#   else
#     new_c = c
#   end
#   new_c
# end
#
#
#
#
puts rot13(%w[Gb trg gb gur bgure fvqr!])