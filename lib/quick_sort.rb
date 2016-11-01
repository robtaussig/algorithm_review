require 'benchmark'

def quicksort(arr,left=0,right=arr.length - 1)
  if arr.length > 1
    pivot = partition(arr,left,right)
    if left < pivot
      quicksort(arr,left,pivot)
    end
    if pivot < right
      quicksort(arr,pivot + 1,right)
    end
  end
  arr
end

def partition(arr,left,right)
  mid = left + (right - left) / 2
  while left < right - 2 do
    while arr[left] < arr[mid] do
      left += 1
    end
    while arr[mid] < arr[right] do
      right -= 1
    end
    if (left < right)
      swap(arr,left,right)
      left += 1
      right -= 1
    end
  end
  left
end

def swap(arr,left,right)
  temp = arr[left]
  arr[left] = arr[right]
  arr[right] = temp
end

# list = Array.new(1000000).map{|i| rand(1000)}
# Benchmark.bmbm do |x|
# 	x.report('quicksort') { quicksort(list) }
# end

list = Array.new(100).map{|i| rand(100)}
p quicksort(list)
