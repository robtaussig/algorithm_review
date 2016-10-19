class Stack
  attr_accessor :stack
  def initialize
    @stack = []
    @min_stack = [1.0/0.0]
  end

  def push(val)
    @min_stack << (val < @min_stack.last ? val : @min_stack.last)
    @stack << val
  end

  def pop
    @min_stack.pop
    @stack.pop
  end

  def is_empty?
    @stack.empty?
  end

  def min
    @min_stack.last
  end

  def peek
    @stack.last
  end

  def length
    @stack.length
  end

  def to_s
    result = []
    @stack.each do |el|
      result << el
    end
    result
  end

  def _shift
    @stack.shift
  end

end


class SetOfStacks
  def initialize(capacity)
    @capacity = capacity
    first_stack = Stack.new
    @stacks = [first_stack]
  end

  def push(val)
    stack = @stacks.last
    if stack.length < @capacity
      @stacks.last.push(val)
    else
      @stacks << Stack.new
      @stacks.last.push(val)
    end
  end

  def pop
    return if @stacks.empty?
    stack = @stacks.last
    if stack.is_empty?
      @stacks.pop
      pop
    else
      result = stack.pop
      if stack.is_empty?
        @stacks.pop
      end
    end
    result
  end

  def pop_at(stack_idx)
    return unless @stacks[stack_idx] && @stacks[stack_idx].length > 0
    return_value = @stacks[stack_idx].pop
    @stacks.each_with_index do |stack,idx|
      if idx > stack_idx && @stacks[idx] && @stacks[idx].length > 0 && @stacks[idx - 1]
        @stacks[idx - 1].push(@stacks[idx]._shift)
      end
    end
    if @stacks.last.is_empty?
      @stacks.pop
    end
    return_value
  end

  def to_s
    result = []
    @stacks.each do |stack|
      result << stack.to_s
    end
    result
  end
end

class MyQueue
  def initialize
    @enqueue_stack = Stack.new
    @dequeue_stack = Stack.new
  end

  def enqueue(val)
    if @dequeue_stack.is_empty?
      @enqueue_stack.push(val)
    else
      @dequeue_stack.length.times do
        @enqueue_stack.push(@dequeue_stack.pop)
      end
      @enqueue_stack.push(val)
    end
  end

  def dequeue
    if @enqueue_stack.is_empty?
      result = @dequeue_stack.pop
    else
      @enqueue_stack.length.times do
        @dequeue_stack.push(@enqueue_stack.pop)
      end
      result = @dequeue_stack.pop
    end
    result
  end

  def to_s
    result = []
    if @enqueue_stack.is_empty?
      result = @dequeue_stack.stack.reverse
    else
      result = @enqueue_stack.to_s
    end
    result
  end
end
