Line = Struct.new(:time, :type, :msg)
LOG_FORMAT = /(\d{2}:\d{2}) (\w+) (.*)/
def parse_line(line)
  line.match(LOG_FORMAT) { |m| Line.new(*m.captures) }
end

p parse_line("12:41 INFO User has logged in.")

m = "John 31".match /\w+ (\d+)/
puts m[1]