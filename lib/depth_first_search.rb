def depth_first_search(node, target)
  return nil if node.nil?
  return node if node == target
  node.children.each do |child|
    result = depth_first_search(child, target)
    return result unless result.nil?
  end
  nil
end
