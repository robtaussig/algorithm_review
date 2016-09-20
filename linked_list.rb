require 'byebug'
class LinkedList
  attr_accessor :head, :tail
  def initialize
    @head = LinkedListNode.new(nil)
    @tail = LinkedListNode.new(nil)
    @head.next = @tail
    @tail.prev = @head
  end

  def append(value)
    new_node = LinkedListNode.new(value)
    new_node.next = @tail
    @tail.prev.next = new_node
    new_node.prev = @tail.prev
    @tail.prev = new_node
  end

  def prepend(value)
    new_node = LinkedListNode.new(value)
    new_node.prev = @head
    @head.next.prev = new_node
    new_node.next = @head.next
    @head.next = new_node
  end

  def remove(node)
    node.next.prev = node.prev
    node.prev.next = node.next
  end

  def convert_array(array)
    new_linked_list = LinkedList.new
    array.each do |el|
      new_linked_list.append(el)
    end
    new_linked_list
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def [](idx)
    j = 0
    test_node = @head
    while j <= idx
      test_node = test_node.next
      j += 1
    end
    test_node
  end

  def to_s
    result = []
    test_node = @head
    until test_node.next.value == nil
      result << test_node.next.value
      test_node = test_node.next
    end
    result
  end

  def swap(node1,node2)
    temp_prev1 = node1.prev
    temp_next1 = node1.next
    node1.next = node2.next
    node1.next.prev = node1
    node1.prev = node2.prev
    node1.prev.next = node1
    node2.next = temp_next1
    node2.next.prev = node2
    node2.prev = temp_prev1
    node2.prev.next = node2
  end

  def count(value)
    count = 0
    test_node = @head
    until test_node.next.value == nil
      count += test_node.next.value == value ? 1 : 0
      test_node = test_node.next
    end
    count
  end

end

class LinkedListNode
  attr_accessor :value, :next, :prev
  def initialize(value = nil, next_node = nil, prev_node = nil)
    @value = value
    @next = next_node
    @prev = prev_node
  end

  def to_s
    "#{@value}"
  end

end
