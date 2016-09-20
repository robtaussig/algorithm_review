require 'benchmark'

def quicksort(array)
  return array if array.length < 2
  pivot = [array.first]
  left = array[1..-1].select{ |x| x < pivot[0] }
  right = array[1..-1].select{ |x| x >= pivot[0] }
  quicksort(left) + pivot + quicksort(right)
end

list = Array.new(1000000).map{|i| rand(1000)}
Benchmark.bmbm do |x|
	x.report('quicksort') { quicksort(list) }
end
