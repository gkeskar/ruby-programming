a = [1, 5, 1, 2, 10, 100, 3, 1]

def bubble_sort (a)
  n = a.length

  loop do
    swapped = false
    (n-1).times do |i|

      puts "working on index: #{i} and #{i+1}"
      puts "comparing #{a[i]} to #{a[i+1]}"

      if a[i] > a[i+1]
        puts "#{i} index comparison iteration"
        a[i] , a[i+1] = a[i+1], a[i]
        swapped = true
        puts "swapped"
        else
        puts "no swap"
      end
    end
    break if not swapped
  end
  a
end

p bubble_sort(a)

