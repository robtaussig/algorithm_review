class Queue
  def initialize
    @queue = []
  end

  def enqueue(val)
    @queue << val
  end

  def dequeue
    @queue.shift
  end

  def peek
    @queue.first
  end

  def is_empty?
    @queue.empty?
  end
end
