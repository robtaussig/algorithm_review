def binary_search(array,target)
  probeIdx = array.length / 2
  case array[probeIdx] <=> target
  when 0
    return probeIdx
  when 1
    return binary_search(array.take(probeIdx),target)
  when -1
    sub_answer = binary_search(array.drop(probeIdx + 1),target)
    return sub_answer.nil? ? nil : sub_answer + probeIdx + 1
  end
  nil
end
