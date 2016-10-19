#Implement algorithm to determine if a string has all unique characters.

#O(n) time complexity
def string_unique_chars?(str)
  char_count = Hash.new(0)
  i = 0
  while i < str.length
    char_count[str[i]] += 1
    if char_count[str[i]] > 1
      return false
    end
    i += 1
  end
  true
end

#Given two strings, write a method to decide if one is a permutation of the other

#O(n) time complexity
def permutation_of_other?(str1,str2)
  if str1.length > str2.length
    smaller_string = str2
    longer_string = str1
  else
    smaller_string = str1
    longer_string = str2
  end
  count = 0
  string_hash = Hash.new(0)
  i = 0
  while i < smaller_string.length
    string_hash[smaller_string[i]] += 1
    i += 1
  end
  j = 0
  while j < longer_string.length
    if count == 0
      test_hash = Hash.new(0)
    end
    if string_hash[longer_string[j]] > 0 && test_hash[longer_string[j]] < string_hash[longer_string[j]]
      count += 1
      test_hash[longer_string[j]] += 1
    else
      count = 0
    end
    return true if count == smaller_string.length
    j += 1
  end
  false
end

# puts permutation_of_other?("hellsdafasdfasdfo","dasf") # this is a subset,
# but still good to know

# O(n) time complexity
def permutation_of_palindrome?(str)
  char_count = Hash.new(0)
  i = 0
  new_str = str.split(' ').join('')
  while i < new_str.length
    if (new_str[i]) != ' '
      char_count[new_str[i]] += 1
    end
    i += 1
  end
  odd_count = 0 + (new_str.length % 2 == 0 ? 1 : 0)
  j = 0
  char_count.values.each do |value|
    if value % 2 == 1
      odd_count += 1
    end
  end
  odd_count == 1
end

# There are three types of edits that can be performed on strings: insert,
# remove, and replace a character. Given two strings, write a function to check
# if they are one (or zero) edits away

# O(n) time complexity
def one_away(str1,str2)
  i,j = 0,0
  idx_equalizer = str1.length == str2.length ? 1 : 0
  diff_count = 0
  if str1.length > str2.length
    long_string = str1
    short_string = str2
  else
    long_string = str2
    short_string = str1
  end
  while i + j < long_string.length + short_string.length
    if long_string[i] == short_string[j]
      i += 1
      j += 1
    else
      diff_count += 1
      i += 1
      j += idx_equalizer
      idx_equalizer = 0
    end
  end
  diff_count <= 1
end

# Implement a method to perform basic string compression using the counts of
# repeated characters. e.g., aabccccaaa = a2b1c5a3

# O(n) time complexity

def string_compression(str)
  last_char = str[0]
  count = 0
  new_string = ""
  i = 0
  while i < str.length
    if last_char == str[i]
      count += 1
    else
      new_string << "#{last_char}#{count}"
      count = 1
    end
    last_char = str[i]
    i += 1
  end
  new_string << "#{last_char}#{count}"
  if new_string.length == str.length * 2
    return str
  else
    return new_string
  end
end

test_matrix = [
  [6,3, 2, 4],
  [2,1, 5, 5],
  [3,0, 1, 7],
  [4,2, 9, 0],
]

# Given an image represented by an NxN matrix, where each pixel in the image is
# 4 bytes, write a method to rotate the image by 90 degrees.

# O(n^2) time complexity
def rotate_matrix(matrix)
  rotated = []
  matrix.length.times do
    rotated << []
  end
  matrix.each_with_index do |row,i|
    row.each_with_index do |square,j|
      rotated_x = row.length - 1 - j
      rotated_y = i
      rotated[rotated_x][rotated_y] = matrix[i][j]
    end
  end
  rotated
end

# Write an algorithm such that if an element in an MxN matrix is 0, its entire
# row and column are set to 0

# O(m * n) time complexity

def zero_matrix(matrix)
  zeros = {
    x: {

    },
    y: {

    }
  }

  matrix.each_with_index do |row,i|
    row.each_with_index do |square,j|
      if square == 0
        zeros[:x][i] = true
        zeros[:y][j] = true
      end
    end
  end

  matrix.length.times do |i|
    matrix[0].length.times do |j|
      if zeros[:x][i] || zeros[:y][j]
        matrix[i][j] = 0
      end
    end
  end
  matrix
end
