#!/usr/bin/env ruby
require_relative 'classes/Todo_list'


todos = TodoList.new
story = Story.new(title: "First Story", priority: 50)


# puts story.title
# puts story.priority
# todos.push Story.new(title: "First Story", priority: 50)
# #puts "#{todos[0].priority}: #{todos[0].title}"
# puts story.inspect

todos = TodoList.new
todos.push Story.new(title: "First Story", priority: 50)
todos.push Story.new(title: "Second, More Important Story", priority: 30)
todos.push Bug.new(title: "The first story broke this thing", priority: 50, steps: ["Add First Story", "reload"])
todos.push Story.new(title: "Nice to have story", priority: 70)


def assert(bool)
  puts bool ? "OK" : "FAILED"
end

# `Bug` raises `Exception` when steps are missing
begin
  Bug.new() && assert(false)
rescue Exception
  assert(true)
end

puts "####"
puts todos