require 'byebug'

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

p anagram_grouper(['hello', 'looeh', 'robert', 'joey', 'bugger', 'trebor', 'oeyj', 'olohe'])
