require 'byebug'
#TodoList should behave like an Array
class TodoList < Array

  def sorted_by_priority
    puts sort_by(&:priority)
  end

  def push(obj)
    super
    sort!
  end

end
# class TodoList
#   attr_accessor :list
#   delegate :push, to: list
#
#   def initialize()
#     self.list = Array.new
#   end
# end

# `Story` should have 2 attributes, `title` and `priority`.
module TodoListItem
  attr_accessor :title, :priority

  def initialize(options={})
    self.title = options[:title]
    self.priority = options[:priority]
  end

  def to_s()
    "#{self.class}: #{@priority}: #{@title}"
  end

  def inspect
    to_s()
  end

  def <=>(other)
    priority <=> other.priority
  end

end

class Story
  include TodoListItem
end

class BugException < Exception
end

class Bug
  include TodoListItem
  attr_accessor :steps

  def initialize(options={})

    unless self.steps = options[:steps]
      raise BugException.new('steps are missing')
    end
    super(options)
  end
end
