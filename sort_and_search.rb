require 'byebug'
require_relative 'bit_set'
require_relative 'binary_search_tree'

# 10.1 You are given two sorted arrays, A and Bm where A has a large enough
# buffer at the end to hold B. Write a method to merge B into A in sorted order.
def sorted_merge(array_a, array_b)
  combined_length = array_a.length + array_b.length
  i = 0
  j = 0
  while i < combined_length
    if i >= array_a.length
      array_a << array_b[j]
      j += 1
    elsif array_a[i] > array_b[j]
      array_a.insert(i, array_b[j])
      j += 1
    end
    break if array_a.length == combined_length
    i += 1
  end
  array_a
end

# p sorted_merge([1,2,5,7,9,10,14],[2,4,5,6,9,10,11,14,16])

# 10.2 Write a method to sort an array of strings so that all the anagrams are
# next to each other.

def anagram_grouper(array)
  mapped_array = array.each_with_index.map { |el,idx| [sort_string(el),idx] }
  sorted_array = sort_array(mapped_array)
  i = 0
  result = []
  while i < sorted_array.length
    result[i] = array[sorted_array[i][1]]
    i += 1
  end
  result
end

def sort_string(string)
  return string if string.length < 2
  pivot = string[0]
  left = string[1..-1].split('').select { |char| char < pivot }.join()
  right = string[1..-1].split('').select { |char| char >= pivot }.join()
  sort_string(left) + pivot + sort_string(right)
end

def sort_array(array)
  return array if array.length < 2
  pivot = array[0]
  left = array[1..-1].select { |el| el[0] < pivot[0] }
  right = array[1..-1].select { |el| el[0] >= pivot[0] }
  sort_array(left) + [pivot] + sort_array(right)
end

# p anagram_grouper(['hello', 'looeh', 'robert', 'joey', 'bugger', 'trebor', 'oeyj', 'olohe'])

# 10.4 Sorted search, no size. You are given an array-like data structure Listy
# which lacks a size method, but can return an element at index(i) in O(1) time.
# If (i) is beyond the bounds of the data structure, it returns -1. Given a
# Listy with sorted, positive integers, find the index at which an element X
# occurs. If it occurs multiple times, return any index.

class Listy
  def initialize(array)
    @listy = array
  end

  def elementAt(i)
    return -1 unless i < @listy.length
    @listy[i]
  end
end

def find_element(target,arr)
  listy = Listy.new(arr)
  probeIdx = 1
  until listy.elementAt(probeIdx * 2) == -1
    probeIdx *= 2
  end
  initialProbe = probeIdx
  until listy.elementAt(probeIdx) == target
    if target > listy.elementAt(probeIdx)
      if listy.elementAt(probeIdx * 1.5) == -1
        return - 1 if listy.elementAt(probeIdx + 1) == -1
        probeIdx += 1
      else
        probeIdx = (probeIdx * 1.5).round
        return - 1 if probeIdx == initialProbe
      end
    elsif target < listy.elementAt(probeIdx)
       return - 1 if probeIdx == 0
      probeIdx /= 2
    end
  end
  if listy.elementAt(probeIdx) == target
    probeIdx
  else
    -1
  end
end

array = [1,4,6,8,9,10,13,15,17,19,22,25,29]

# p find_element(25,array)

# 10.8 You have an array with all numbers from 1 to N, where N is at most
# 32,000. The array may have duplicate entries, and you do not know what N is.
# With only 4kilobytes of memory available, how would you print all duplicate
# elements in the array?

def print_duplicates(array)
  bit_set = BitSet.new(32000)
  # debugger
  duplicates = []
  array.each do |el|
    if bit_set[el] == 1
      duplicates << el
    end
    bit_set.on(el)
  end
  duplicates
end

# array = (1...32000).to_a.map { |el| rand(el) }

# p print_duplicates(array)

# 10.9 Given an M x N matrix in which each row and each column is sorted in
# ascending order, write a method to find an element

def find_element_in_sorted_matrix(target,matrix)
  x_probe = matrix[0].length / 2
  y_probe = matrix.length / 2
  count = 0
  until matrix[y_probe][x_probe][0] == target
    probed_vertex = matrix[y_probe][x_probe][0]
    if probed_vertex > target
      x_probe /= 2
      if matrix[y_probe][0][0] > target
        y_probe /= 2
      else
        y_probe += (matrix.length - y_probe) / 2
      end
      if x_probe < matrix[0].length - 1 && matrix[y_probe][x_probe + 1][0] == target
        x_probe += 1
      elsif y_probe < matrix.length - 1 && matrix[y_probe + 1][x_probe][0] == target
        y_probe += 1
      elsif x_probe > 0 && matrix[y_probe][x_probe - 1][0] == target
        x_probe -= 1
      elsif y_probe > 0 && matrix[y_probe - 1][x_probe][0] == target
        y_probe -= 1
      end
    elsif probed_vertex < target
      x_probe += (matrix[0].length - x_probe) / 2
      if matrix[y_probe][0][0] > target
        y_probe /= 2
      else
        y_probe += (matrix.length - y_probe) / 2
      end
      if x_probe < matrix[0].length - 1 && matrix[y_probe][x_probe + 1][0] == target
        x_probe += 1
      elsif y_probe < matrix.length - 1 && matrix[y_probe + 1][x_probe][0] == target
        y_probe += 1
      elsif x_probe > 0 && matrix[y_probe][x_probe - 1][0] == target
        x_probe -= 1
      elsif y_probe > 0 && matrix[y_probe - 1][x_probe][0] == target
        y_probe -= 1
      end
    end
    if y_probe * x_probe == 0 || y_probe == matrix.length || x_probe == matrix[0].length
      if matrix[y_probe][x_probe][0] == target
        return y_probe,x_probe
      else
        return nil
      end
    end
  end
  return x_probe, y_probe
end

# matrix = [
#   [[3], [4], [5], [6], [7], [8]],
#   [[5], [7], [9], [13],[14],[16]],
#   [[7], [8], [10],[14],[15],[17]],
#   [[9], [13],[14],[15],[17],[18]],
#   [[11],[18],[19],[21],[22],[23]],
#   [[12],[19],[20],[23],[24],[25]],
# ]
#
# find_element_in_sorted_matrix(4,matrix)

# 10.10 Imagine reading a stream of integers. Periodically, you wish to be able
# to look up the rank of a number, measured by how many numbers of values less
# or equal to it. Implement a data structure for this.

tree = BinarySearchTree.new([5,2,3,1,7,9,6,10])
p tree
