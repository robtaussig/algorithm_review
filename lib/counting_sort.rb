require 'benchmark'


def counting_sort(array)
  count = Array.new(array.max + 1,0)
  i = 0
  while i < array.length
    count[array[i]] += 1
    i += 1
  end
  j = 1
  while j < count.length
    count[j] = count[j] + count[j-1]
    j += 1
  end
  result = Array.new(array.length)
  k = 0
  while k < array.length
    result[count[array[k]]] = array[k]
    count[array[k]] = count[array[k]] - 1
    k += 1
  end
  result
end

list = Array.new(1000000).map{|i| rand(1000)}
Benchmark.bmbm do |x|
	x.report('counting_sort') { counting_sort(list) }
end
