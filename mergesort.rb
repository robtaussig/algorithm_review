require 'benchmark'

def mergesort(array)
  return array if array.length < 2
  left, right = array.take(array.length / 2), array.drop(array.length / 2)
  merge(mergesort(left),mergesort(right))
end

def merge(left,right)
  merged = []
  until left.empty? || right.empty?
    merged << (left.first > right.first ? right.shift : left.shift)
  end
  merged + left + right
end

list = Array.new(1000000).map{|i| rand(1000)}

Benchmark.bmbm do |x|
	x.report('mergesort') { mergesort(list) }
end
