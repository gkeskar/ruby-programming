def full_name(first_name, *rest)
  # require 'byebug'; byebug
  # first_name + " " + rest.join(" ")
  rest.reduce(first_name){|x, y| x + " " + y}
end


puts full_name('Horc', 'G.', 'M.', 'Moon')