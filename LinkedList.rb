class Node
  attr_accessor :data, :next_node, :prev_node
  
  def initialize(data)
    self.next_node = nil
    self.prev_node = nil
    self.data = data
  end
end

class LinkedList
  attr_accessor :head, :tail

  def initialize()
    self.head = nil
    self.tail = nil
  end
  
  def append(node)
    # add an element to the end of the linked list or make it the head if it's empty
    if self.head.nil?
      self.head = node
    else
      current_node = self.head
      until current_node.next_node.nil?
        current_node = self.head.next_node
      end
      current_node.next_node = node
      self.tail = current_node.next_node
      current_node.next_node.prev_node = current_node
    end

  end
end

node = Node.new(8)
puts node.data

ll = LinkedList.new()
puts ll
puts ll.head
puts ll.tail

ll.append(node)
puts ll.head.data
puts ll.tail.data
