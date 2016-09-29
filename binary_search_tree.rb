require_relative 'graph'

class BinarySearchTree
  def initialize(array)
    @sorted = quicksort(array)
    @tree = Graph.new
    build_tree(@sorted)
  end

  def quicksort(array)
    return array if array.length < 2
    pivot = array[0]
    left = quicksort(array[1..-1].select{|el| el < pivot})
    right = quicksort(array[1..-1].select{|el| el >= pivot})
    left + [pivot] + right
  end

  def build_tree(array, left=0, right=array.length-1)
    return if left > right
    index_mid = left + (right-left) / 2
    node = Vertex.new(array[index_mid])
    @tree.vertices << node
    node.neighbors << build_tree(array,left, index_mid - 1)
    node.neighbors << build_tree(array,index_mid + 1, right)
    node
  end
end
