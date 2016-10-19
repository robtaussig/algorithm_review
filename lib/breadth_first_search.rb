def breadth_first_search(node,target)
  queue = [node]
  until queue.empty?
    test_node = queue.shift
    return test_node if test_node == target
    test_node.children.each { |child| queue << child }
  end
  nil
end
