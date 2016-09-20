require_relative 'linked_list'

# 2.1 write code to remove duplicates from an unsorted linked list (O(n) time)
# bonus: do it without a temporary buffer (will be in O(n^2) time)

def remove_duplicates(linked_list)
  duplicate_hash = Hash.new(0)
  test_node = linked_list.head.next
  until test_node.next.value == nil
    next_node = test_node.next
    if duplicate_hash[test_node.value] > 0
      linked_list.remove(test_node)
    end
    duplicate_hash[test_node.value] += 1
    test_node = next_node
  end
  linked_list
end

def remove_duplicates_no_buffer(linked_list)
  test_node = linked_list.head.next
  until test_node.next.value == nil
    racer_node = test_node.next
    until racer_node.value == nil
      if racer_node.value == test_node.value
        next_node = racer_node.prev
        linked_list.remove(racer_node)
        racer_node = next_node
      end
      racer_node = racer_node.next
    end
    test_node = test_node.next
  end
  linked_list
end

# duplicate_linked_list = LinkedList.new.convert_array([1,7,3,2,7,5,2,7,9])

# unique_linked_list = remove_duplicates(duplicate_linked_list)
# unique_linked_list_no_buffer = remove_duplicates_no_buffer(duplicate_linked_list)

# 2.2 Implement an algorithm to find the kth to last element of a singly linked list
# below is doubly linked list, but we are not calling prev on anything
# O(n) time complexity

def find_kth_last_link(linked_list, k)
  scout_node = linked_list.head.next
  k.times do
    scout_node = scout_node.next
  end
  test_node = linked_list.head.next
  until scout_node.value == nil
    scout_node = scout_node.next
    test_node = test_node.next
  end
  test_node
end

# linked_list = LinkedList.new.convert_array([1,4,2,3,4,7,8,4,3,2,1,7])
# kth_to_last_value =  find_kth_last_link(linked_list,7)

# 2.3 implement an algorithm to delete a node in the middle of a singly linked list,
# given access to only that node

def delete_middle_node(linked_list,kth_node)
  to_delete = linked_list[kth_node]
  next_node = to_delete.next
  to_delete.value = next_node.value
  until next_node.value == nil
    next_node.value = next_node.next.value
    next_node = next_node.next
  end
  linked_list
end

# linked_list = LinkedList.new.convert_array([1,4,2,3,4,7,8,4,3,2,1,7])
# p delete_middle_node(linked_list,6).to_s

# 2.4 Write code to partition a linked list around a value x, such that all
# nodes less than x come before all nodes greater than or equal to x. If x is
# contained within the list, the values of x only need to be after the elements
# less than x. The partition element x can appear anywhere in the right side.
# e.g., : 3, 5, 8, 5, 10, 2, 1 /5/ => 3, 1, 2, 10, 5, 5, 8

def partition_linked_list(linked_list, partition_value)
  test_node = linked_list.head.next
  until test_node.next.value == nil
    if test_node.value < partition_value
      next_node = test_node.next
      linked_list.prepend(test_node.value)
      linked_list.remove(test_node)
      test_node = next_node
    else
      test_node = test_node.next
    end
  end
  linked_list
end

# linked_list = LinkedList.new.convert_array([1,4,2,6,3,4,7,8,6,4,3,2,1,6,7])
# p partition_linked_list(linked_list,6).to_s

# 2.5 You have two numbers represented by a linked list, where each node
# contains a single digit. The digits are stored in reverse order, such that the
# 1's digit is at the head of the list. Write a function that adds the two
# numbers and returns the sum as a linked list

def add_reversed_digits(linked_list1, linked_list2)
  parse_linked_list_digit(linked_list1) + parse_linked_list_digit(linked_list2)
end

def parse_linked_list_digit(linked_list)
  tens = 0
  count = 0
  start = linked_list.head.next
  until start.value == nil
    count += (start.value * 10 ** tens)
    tens += 1
    start = start.next
  end
  count
end

linked_list1 = LinkedList.new.convert_array([7,1,6])
linked_list2 = LinkedList.new.convert_array([5,9,2])
p add_reversed_digits(linked_list1, linked_list2)
