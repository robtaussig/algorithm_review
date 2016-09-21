require_relative 'graph'
require 'byebug'
require_relative 'queue'
require_relative 'linked_list'

vertices = {
  a: [:b,:c,:d],
  b: [:c, :d],
  c: [:d, :e, :f],
  d: [:g, :h],
  e: [:h, :g],
  f: [:j],
  g: [],
  h: [:i, :r],
  i: [:r],
  j: [:r],
  r: []
}

graph = Graph.new
graph.create_graph_from_hash(vertices)
# 4.1 Given a directed graph, design an algorithm to find out whether there is
# a route between two nodes
def any_route?(graph, start_node, end_node)
  queue = Queue.new
  visited = Hash.new(false)
  node = graph.find_vertex(start_node)
  queue.enqueue(node)
  until queue.is_empty?
    test_node = queue.dequeue
    return true if test_node.value == end_node
    unless visited[test_node]
      test_node.neighbors.each do |node|
        neighbor_node = graph.find_vertex(node)
        queue.enqueue(neighbor_node)
      end
    end
    visited[test_node] = true
  end
  false
end

# 4.2 given a sorted (increasing order) array with unique integer elements,
# write an algorithm to create a binary search tree with minimal height

=begin
  e.g. [1,2,3,4,5,6,7,8] ==>

        4
      /   \
     2     7
    / \   /  \
   1   3 5    8
          \
           6
=end

def build_BST(array, left=0, right=array.length-1)
  return if left > right
  index_mid = left + (right-left) / 2
  node = Vertex.new(array[index_mid])
  node.neighbors[0] = build_BST(array,left, index_mid - 1)
  node.neighbors[1] = build_BST(array,index_mid + 1, right)
  node
end

# p build_BST([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15])

def BST_depth_to_linked_list(array)
  bst = build_BST(array)
  visited = Hash.new(false)
  values = []
  queue = Queue.new
  queue.enqueue(bst)
  values << bst.value
  until queue.is_empty?
    node = queue.dequeue
    unless visited[node.value]
      node.neighbors.each do |neighbor|
        if neighbor
          values << neighbor.value
          queue.enqueue(neighbor)
        end
      end
    end
    visited[node.value] = true
  end
  linked_lists = [LinkedList.new]
  depth = 1
  values.each_with_index do |val, idx|
    if idx == (2 ** depth) - 1
      linked_lists << LinkedList.new
      depth += 1
    end
    linked_lists.last.append(val)
  end
  linked_lists
end

p BST_depth_to_linked_list([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15])
