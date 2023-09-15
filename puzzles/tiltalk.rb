#Given a string s, return the first non-repeating character's index. If it does not exist, return -1.

#Example 1:
#Input: s = "bytedance"
#Output: 0
#Example 2:
#Input: s = "lovebytedancelo”
#Output: 2
#Example 3:
#Input: s = "aabb"
#Output: -1

s = "aabb"
require 'byebug'

def non_repeating_char(input)
    # input.chars.chunk{ |c| c }.map {|letter,arr| arr.size == 1 ? letter : -1 }.first


   output = input.chars.each_with_object(Hash.new(0)) do |c, hash|
      hash[c] += 1
   end

   result = output.each_with_object([]) do | (k , v), arr|
       if v == 1
         arr << k
       end
     end

     return -1 if result.empty?
     result.first
end

puts non_repeating_char("bytedance")
puts non_repeating_char("lovebytedancelo")
puts non_repeating_char("aabb")
