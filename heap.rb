class Heap
  attr_accessor :nodes
  def initialize(arr)
    build_tree(arr)
    heapify
  end

  def build_tree(arr)
    @nodes = arr.map do |el|
      Node.new(el)
    end
  end

  def heapify
    start = (@nodes.length - 2) / 2
    while start >= 0 do
      sift_down(start)
      start -= 1
    end
    @nodes.each_with_index do |node,idx|
      node.add_parent(@nodes[idx / 2]) unless idx == 0
      node.add_child(@nodes[idx * 2 + 1]) if @nodes[idx * 2 + 1]
      node.add_child(@nodes[idx * 2 + 2]) if @nodes[idx * 2 + 2]
    end
  end

  def sift_down(start,end_point=@nodes.length - 1)
    root = start
    while root * 2 + 1 <= end_point do
      child = root * 2 + 1
      if child + 1 <= end_point && @nodes[child].value < @nodes[child + 1].value
        child += 1
      end
      if @nodes[root].value < @nodes[child].value
        @nodes[root].swap(@nodes[child])
        root = child
      else
        return
      end
    end
    return
  end

  def heapsort
    end_point = @nodes.length - 1
    while end_point > 0 do
      @nodes[0].swap(@nodes[end_point])
      end_point -= 1
      sift_down(0,end_point)
    end
    @nodes
  end

  def children(index)
    @nodes[index].children.map { |child| child.to_s }
  end

  def parent(index)
    @nodes[index].parent.to_s
  end

  def to_s
    @nodes.map {|node| node.value}
  end

  def find_node_by_val(val)
    @nodes.select { |node| node.value == val}[0]
  end
end

class Node
  attr_accessor :children, :value, :parent
  def initialize(val,parent=nil)
    @value = val
    @children = []
    @parent = parent
  end

  def add_child(node)
    @children << node
    node.parent = self
  end

  def swap(node)
    this_value = @value
    that_value = node.value
    @value = that_value
    node.value = this_value
  end

  def to_s
    @value
  end

  def add_parent(node)
    @parent = node
  end

  def remove_child(node)
    @children = @children.select { |child| child != node }
  end
end
