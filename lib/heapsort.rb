require 'benchmark'

def heapsort(array)
  count = array.length
  new_array = heapify(array,count)
  end_point = count - 1
  while end_point > 0 do
    new_array = swap(array,end_point,0)
    end_point -= 1
    sift_down(array, 0, end_point)
  end
  return new_array;
end

def heapify(array,count)
  start = (count - 2) / 2
  while start >= 0 do
    sift_down(array,start,count - 1)
    start -= 1
  end
end

def sift_down(array,start, end_point)
  root = start
  while root * 2 + 1 <= end_point do
    child = root * 2 + 1
    if child + 1 <= end_point && array[child] < array[child + 1]
      child += 1
    end
    if array[root] < array[child]
      array = swap(array,root,child)
      root = child
    else
      return array
    end
  end
  return array
end

def swap(array,root,child)
  temp = array[root]
  array[root] = array[child]
  array[child] = temp
  return array
end

list = Array.new(1000000).map{|i| rand(1000)}

Benchmark.bmbm do |x|
	x.report('heapsort') { heapsort(list) }
end
