require 'byebug'
require_relative 'bit_set'
# 16.1 - Write a function to swap a number in place (without a temp variable)

def num_swapper(num1,num2)
	num1 = num2 + num1
	num2 = num1 - num2
	num1 = num1 - num2
	[num1, num2]
end

def xor_num_swapper(num1,num2)
	num1 = num1 ^ num2
	num2 = num1 ^ num2
	num1 = num1 ^ num2
	[num1,num2]
end

# p xor_num_swapper(5,4)

# 16.2 - Design a method to find the frequency of occurrences of any given word
# in a book. What if we were to run this algorithm multiple times?

def word_frequencies(word, book_text)
	word_table = Hash.new(0)
	book_text.split(' ').each do |word|
		word_table[word.downcase.gsub(/[^A-Za-z0-9\s]/i, '')] += 1
	end
	word_table[word.downcase]
end

# book_test = File.readlines("mobydick.txt").join("\n").gsub("\n"," ")
#
# p word_frequencies("moby", book_test)

# 16.3 Write a function to determine the intersection of two lines, inputted
# as the coordinates of the start and end point.
def find_intersection(line1, line2)
  line1_slope = (line1[1][1] - line1[0][1]).to_f / (line1[1][0] - line1[0][0])
  line2_slope = (line2[1][1] - line2[0][1]).to_f / (line2[1][0] - line2[0][0])
  if [line1[0][0],line1[1][0]].max > 0
    closest_to_zero = line1.sort_by {|x| x[0]}.first
    line1_intersect = closest_to_zero[1] - closest_to_zero[0]*line1_slope
  else
    closest_to_zero = line1.sort_by {|x| x[0]}.last
    line1_intersect = closest_to_zero[1] + (closest_to_zero[0].abs*line1_slope)
  end
  if [line2[0][0],line2[1][0]].max > 0
    closest_to_zero = line2.sort_by {|x| x[0]}.first
    line2_intersect = closest_to_zero[1] - closest_to_zero[0]*line2_slope
  else
    closest_to_zero = line2.sort_by {|x| x[0]}.last
    line2_intersect = closest_to_zero[1] + (closest_to_zero[0].abs*line2_slope)
  end
  x_intersection = (line2_intersect - line1_intersect).to_f / (line1_slope - line2_slope)
  y_intersection = line1_slope * x_intersection + line1_intersect
  [x_intersection,y_intersection]
end

# p find_intersection([[0,0],[5,9]],[[4,0],[-2,7]])

# 16.4 Design an algorithm to figure out if someone has won a game of tic-tac-toe

grid = [
          ["X"],["O"],["O"],
          ["X"],["X"],["O"],
          ["O"],["X"],["O"]
        ]

def find_winner(grid)
  i = 0
  winner_hash = Hash.new("")
  hor_mod = 0
  vert_mod = 3
  diag_mod = 0
  while i < 3
    winner_hash[["hor",i]] = grid[i*3][0] + grid[i*3 + 1][0] + grid[i*3 + 2][0]
    winner_hash[["vert",i]] = grid[i][0] + grid[i+3][0] + grid[i+6][0]
    if i != 1
      winner_hash[["diag",i]] = grid[i][0] + grid[4][0] + grid[8 - i][0]
    end
    i += 1
  end
  return "X wins!" if winner_hash.values.any? {|val| val == "XXX"}
  return "O wins!" if winner_hash.values.any? {|val| val == "OOO"}
  return "tie!"
end

# p find_winner(grid)

# 16.5 Factorial Zeros - Write an algorithm which computes the number of
# trailing zeroes in n factorial

def factorial(n)
	count = 1
	i = 1
	until i > n
		count *= i
		i += 1
	end
	count
end

def num_zeroes_in_factorial(n)
	i = 5
	count = 0
	until n / i == 0
		count += n / i
		i *= 5
	end
	count
end

# n = 25
# p factorial(n)
# p num_zeroes_in_factorial(n)

# 16.6 Given two arrays of integers, compute the pair of values with the
# smallest non-negative difference. Return the difference

def smallest_difference(array1,array2)
	array1_bit_set = BitSet.new(array1.max)
	array1.each do |num|
		array1_bit_set.on(num)
	end

	array2_bit_set = BitSet.new(array2.max)
	array2.each do |num|
		array2_bit_set.on(num)
	end

	curr_min = 1.0/0
	last_long = nil
	last_short = nil

	i = 0

	if array1_bit_set.length > array2_bit_set.length
		long_bit = array1_bit_set
		short_bit = array2_bit_set
	else
		long_bit = array2_bit_set
		short_bit = array1_bit_set
	end

	while i < long_bit.length
		last_long = i if long_bit[i] == 1
		last_short = i if short_bit[i] == 1
		if long_bit[i] == 1 && last_short
			curr_min = curr_min < (i - last_short) ? curr_min : i - last_short
		end

		if short_bit[i] == 1 && last_long
			curr_min = curr_min < (i - last_long) ? curr_min : i - last_long
		end

		i += 1
	end
	curr_min
end

# p smallest_difference([1,3,15,11,2],[23,127,235,19,8])

# 16.7 - Write a method that finds the max of two numbers without using if-else
# or any other comparison operator

def number_max(num1,num2)
	k = (((num1 - num2) >> 31) & 1) ^ 1
	q = k ^ 1
	num1 * k + num2 * q
end

# p number_max(155,15)

# 16.9 - Write methods to implement the multiply, subtract, and division
# operations for integers. The result of all of these are integers. Use only
# the add operator.

def calc(num1,action,num2)
	case action
	when "subtract"
		return add_subtract(num1,num2)
	when "multiply"
		return add_multiply(num1,num2)
	when "divide"
		return add_divide(num1,num2)
	end
	return "incorrect action"
end

def add_multiply(num1,num2)
	# debugger
	count = 0
	i = 0
	until i == num2
		count += num1
		i += 1
	end
	count
end

def add_subtract(num1,num2)
	diff = 0
	if num2 > num1
		large = num2
		small = num1
	else
		large = num1
		small = num2
	end
	i = small
	until i == large
		i += 1
		diff += 1
	end
	diff *= large == num1 ? 1 : -1
end

def add_divide(num1,num2)
	div = 0
	small_num = num2
	until num2 > num1
		div += 1
		num2 += small_num
	end
	div
end

# p calc(5,"multiply",20)
# p calc(40,"subtract",88)
# p calc(80,"divide", 15)

# 16.10 - Living People: Given a list of people with their birth and death years
# implement a method to compute the year with teh most number of people alive
