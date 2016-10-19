require_relative 'graph'
require 'byebug'
require_relative 'queue'
require_relative 'stack'
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

def build_BT(array, left=0, right=array.length-1)
  return if left > right
  index_mid = left + (right-left) / 2
  node = Vertex.new(array[index_mid])
  node.neighbors << build_BT(array,left, index_mid - 1)
  node.neighbors << build_BT(array,index_mid + 1, right)
  node
end

# p build_BT([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15])

# Given a binary tree, design an algorithm which creates a linked list of all
# the nodes at each depth (i.e., if you have a tree with depth D, you'll have
# D linked lists)

def flatten_search_tree(tree,show_values = false)
  visited = Hash.new(false)
  values = []
  queue = Queue.new
  queue.enqueue(tree)
  if show_values
    values << tree.value
  else
    values << tree
  end
  until queue.is_empty?
    node = queue.dequeue
    unless visited[node.value]
      node.neighbors.each do |neighbor|
        if neighbor
          if show_values
            values << neighbor.value
          else
            values << neighbor
          end
          queue.enqueue(neighbor)
        end
      end
    end
    visited[node.value] = true
  end
  values
end

def BST_depth_to_linked_list(array)
  bst = build_BT(array)
  values = flatten_search_tree(bst,true)
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

# p BST_depth_to_linked_list([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15])

# Implement a function to check if a binary tree is balanced. For the purposes
# of this question, a balanced tree is defined to be a tree such that the
# heights of the two subtrees of any node never differ by more than one.
# bonus: Check if it is a valid binary search tree (proper order between nodes)

def balanced_search_tree?(node)
  visited = Hash.new(false)
  queue = Queue.new
  queue.enqueue(node)
  until queue.is_empty?
    node = queue.dequeue
    left = node.neighbors[0]
    right = node.neighbors[1]
    left_height = get_height(left)
    right_height = get_height(right)
    left_value = left ? left.value : -1.0/0.0
    right_value = right ? right.value : 1.0/0.0
    unless left_value <= node.value &&
        right_value > node.value &&
        (left_height - right_height).abs <= 1
      return false
    end
    unless visited[node.value]
      node.neighbors.each do |neighbor|
        if neighbor

          queue.enqueue(neighbor)
        end
      end
    end
    visited[node.value] = true
  end
  true
end

def get_height(node)
  return -1 unless node
  return [get_height(node.neighbors[0]),get_height(node.neighbors[1])].max + 1
end

# tree = build_BT([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18])
# p balanced_search_tree?(tree)

# Build order: you are given a list of projects and a list of dependences, which
# is a list of pairs of projects, where the second project is dependent on the
# first project. All of a project's dependencies must be built before it. Find
# a build order that will allow the projects to be built. Return error if there
# is no valid order.
# E.g. projects: a,b,c,d,e,f : dependences: (a,d),(f,b),(b,d),(f,a),(d,c)
# => f,e,a,b,d,c

def find_build_order(projects, dependencies)
  tree = build_tree(projects, dependencies)
  return nil if tree[1].empty?
  tree[1].each do |start|
    path = find_path(tree[0],tree[0].find_vertex(start),dependencies,projects.length,[start],0)
    return path if path
  end
  nil
end

def find_path(tree,node,rules,depth,path,count)
  return path if path.length == depth
  return nil unless node
  node.neighbors.each do |project|
    unless path.include?(project) || fails_dependencies(project,rules,path)
      path << project
      result = find_path(tree,tree.find_vertex(project),rules,depth,path,count + 1)
    end
    return result unless result.nil?
  end
  nil
end

def fails_dependencies(project,rules,path)
  rules.each do |rule|
    return true if rule[1] == project && !path.include?(rule[0])
  end
  false
end

def build_tree(projects, dependencies)
  graph = Graph.new
  projects.each do |project|
    graph.add_vertex(project)
  end
  dependencies.each do |d|
    graph.add_edge(d[0],d[1])
  end
  free_projects = projects.select do |project|
    dependencies.none? { |d| d[1] == project }
  end
  projects.each do |start_p|
    projects.each do |end_p|
      unless start_p == end_p || dependencies.include?([end_p,start_p])
        graph.add_edge(start_p,end_p)
      end
    end
  end
  [graph,free_projects]
end

# p find_build_order([:a,:b,:c,:d,:e,:f],[[:a,:d],[:f,:b],[:b,:d],[:f,:a],[:d,:c]])

# 4.8 Design an algorithm and write code to find the first common ancestor of
# two nodes in a binary tree (not necessarily BST).

def find_ancestors(binary_tree,node1,node2)
  common_ancestor = nil
  flattened = flatten_search_tree(binary_tree)
  flattened.each do |node|
    if find_target(node, node1,[node]) &&
      find_target(node, node2,[node])
      common_ancestor = node
    end
  end
  common_ancestor.value
end

def find_target(node,target,path)
  return path if path.include?(target)
  return nil unless node
  node.neighbors.each do |project|
    path << project.value if project
    result = find_target(project,target,path)
    return result unless result.nil?
  end
  nil
end

# vertices = [:a,:r,:e,:u,:i,:o,:u,:y,:t,:s,:q,:p]
# binary_tree = build_BT(vertices)
# p find_ancestors(binary_tree,:u,:a)
