require 'byebug'
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

p find_winner(grid)
