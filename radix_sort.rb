require 'benchmark'

def radix_sort(array)
  num_passes = Math.log10(array.max).floor + 1
  digits_place = 0
  num_passes.times do
    modded = (10 ** (digits_place + 1))
    divided = (10 ** digits_place)
    buckets = Array.new(10).map{|x|[]}
    array.each do |el|
      if el < divided
        buckets[0] << el
      else
        digit = el % modded / divided
        buckets[digit] << el
      end
    end
    array = buckets.flatten
    digits_place += 1
  end
  array
end


list = Array.new(1000000).map{|i| rand(1000)}
Benchmark.bmbm do |x|
	x.report('radix_sort') { radix_sort(list) }
end
