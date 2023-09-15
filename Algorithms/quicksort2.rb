

def quick_sort(a)
  # [34, 2, 1, 5, 3]
  return a if a.size <= 1
  a.size
  puts a.size
  # pivot = a[rand(a.size - 1)]
  pivot = a.delete_at(rand(a.length))
  puts "pivot:#{pivot}"
  left_a = []
  right_a = []
  (a.size).times do |i|
    puts "index: #{i}"
    puts "comparing #{a[i]} to #{pivot}"
    if a[i] <= pivot
      left_a.push(a[i])
    else
      right_a.push(a[i])
    end
  end
  puts "left_a: #{left_a}"
  puts "right_a: #{right_a}"
  return *quick_sort(left_a), pivot , *quick_sort(right_a)

end

a =  [34, 2, 1, 5, 3]
puts quick_sort(a)