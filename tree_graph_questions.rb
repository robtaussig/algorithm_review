require_relative 'graph'
require 'byebug'
require_relative 'queue'

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

# 4.2 
