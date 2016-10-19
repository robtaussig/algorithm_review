require_relative 'stack'
require_relative 'queue'
require 'byebug'
# design a stack which has a function to return the min element in 0(1) time
def question_one
  stack = Stack.new
  stack.push(3)
  stack.push(5)
  stack.push(2)
  stack.push(4)
  stack.push(1)
  stack.pop
  stack.pop
  stack.pop
  stack.min
end

# puts question_one

# design a set of stacks, which initialize with a given capacity, and creates
# a new stack whenever one is at capacity. Calling push and pop in the set
# should still act as if they were a single stack. Bonus: add a function to
# pop at a particular index (of the set of stacks). Remember to reshuffle the
# stacks to account for popping at a stack not at the end of the set.

def question_two
  set = SetOfStacks.new(5)
  set.push(3)
  set.push(2)
  set.push(5)
  set.push(1)
  set.push(7)
  set.push(4)
  set.push(2)
  set.push(8)
  set.push(2)
  set.push(1)
  set.push(3)
  set.push(5)
  set.pop
  set.pop_at(1)
  set
end

# p question_two.to_s

# implement a myQueue class which implements a queue using two stacks

def question_three
  dequeued = []
  my_queue = MyQueue.new
  my_queue.enqueue(5)
  my_queue.enqueue(3)
  my_queue.enqueue(2)
  my_queue.enqueue(7)
  my_queue.enqueue(1)
  my_queue.enqueue(2)
  my_queue.enqueue(4)
  dequeued << my_queue.dequeue
  my_queue.enqueue(3)
  my_queue.enqueue(7)
  my_queue.enqueue(1)
  dequeued << my_queue.dequeue
  [my_queue.to_s,dequeued]
end

# p question_three

# write a program that will sort a stack so that the smallest items are on the
# top. You may only use one additional stack for storage, but no other data
# structures (such as an array).

def stack_sort(stack)
  min = 1.0/0.0
  count = 0
  length = stack.length
  to_sort = stack
  storage = Stack.new
  until count == length
    sorted = true
    until to_sort.is_empty?
      test_el = to_sort.pop
      min = test_el < min ? test_el : min
      storage.push(test_el)
    end
    count += 1
    until storage.length < count
      test_el = storage.pop
      if test_el == min
        temp_var = test_el
        until storage.length < count
          to_sort.push(storage.pop)
        end
      else
        to_sort.push(test_el)
      end
    end
    storage.push(temp_var)
    min = 1.0/0.0
  end
  storage.length.times do
    to_sort.push(storage.pop)
  end
  to_sort
end

unsorted_stack = Stack.new
100.times do
  unsorted_stack.push(rand(100))
end

p stack_sort(unsorted_stack).to_s
