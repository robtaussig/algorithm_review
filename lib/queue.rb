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

  def to_s
    @queue.map{|el|el.to_s}
  end
end
