require 'byebug'
require_relative 'graph'

# 8.1 A child is running up a staircase with n steps and can hop either 1 step,
# 2 steps, or 3 steps at a time. Write a method to count how many possible ways
# the child can run up the stairs

def stair_permutations(n)
  queue = []
  cache = Hash.new {|cache,n| cache[n] = cache[n - 1] + cache[n - 2] + cache[n - 3]}
  [1,2,3].each do |step|
    count = 0
    queue.push(step)
    until queue.empty?
      test_node = queue.shift
      if test_node == 0
        count += 1
      end
      [1,2,3].each do |num|
        if num <= test_node
          queue << (test_node - num)
        end
      end
    end
    cache[step] = count
  end
  cache[n]
end

# p stair_permutations(100)

  # 8.2 Imagine a robot sitting on the upper left corner of grid with r rows
  #and c columns. The robot can only move in two directions, right and down, but
  # certain cells are off limits such that the robot cannot step on them. Design
  # an algorithm to find a path for the robot from the top left to bottom right.
  X = 'bomb'
  grid = [
    [[ ],[ ],[ ],[ ],[X],[ ],[X],[ ],[ ],[X]],
    [[ ],[ ],[X],[ ],[ ],[ ],[ ],[ ],[ ],[ ]],
    [[X],[ ],[ ],[ ],[X],[ ],[ ],[ ],[ ],[ ]],
    [[ ],[X],[ ],[X],[X],[X],[X],[ ],[X],[ ]],
    [[ ],[ ],[ ],[ ],[X],[ ],[X],[ ],[X],[ ]],
    [[ ],[X],[ ],[ ],[X],[ ],[ ],[ ],[ ],[X]],
    [[ ],[ ],[X],[ ],[ ],[X],[ ],[ ],[ ],[ ]],
    [[X],[ ],[ ],[X],[X],[ ],[X],[X],[ ],[ ]],
    [[ ],[ ],[ ],[ ],[X],[ ],[X],[ ],[ ],[ ]],
    [[ ],[ ],[X],[ ],[ ],[ ],[ ],[X],[ ],[ ]],
  ]

  def grid_robot(grid)
    grid_hash = Hash.new([])
    x = grid.length
    y = grid[0].length
    x.times do |x_pos|
      y.times do |y_pos|
        grid_hash[[x_pos,y_pos]] = []
      end
    end
    grid_hash.each do |key,_|
    x = key[0]
    y = key[1]
    if grid[x][y].empty?
      grid_hash[[(x - 1),(y)]] << [x,y] unless grid_hash[[(x - 1),(y)]].nil?
      grid_hash[[(x),(y - 1)]] << [x,y] unless grid_hash[[(x),(y - 1)]].nil?
    end
  end
  graph = Graph.new.create_graph_from_hash(grid_hash, directed = true)
  path = find_path(graph,graph.first.value,graph.last.value)
end

def find_path(graph,start,target,path = Array.new)
  return path if start == target
  node = graph.select { |node| node.value == start }[0]
  return nil if node.neighbors.empty?
  node.neighbors.each do |destination|
    unless path.include?(destination)
      path << destination
      result = find_path(graph,destination,target,path)
    end
    if result.nil?
      path.pop
    else
      return result
    end
  end
  nil
end

p grid_robot(grid)

def find_subsets(set)
  return [[]] if set.length == 0
  subs = find_subsets(set.take(set.length - 1))
  subs.concat(subs.map{|el| el + [set.last]})
end

# set = [1,4,7,8]
#
# p find_subsets(set)

# 8.5 Write a recursive function to multiply two positive integers without using
# the * operator. You can use +, -, and bit shifting, but try to minimize the #
# of those operations

def multiply_nums(num1,num2,double,shifts)
  remainder = 0
  if double > num2
    (num2 - (double >> 1)).times do
      remainder += num1
    end
    return (num1 << (shifts - 1)) + remainder
  end
  multiply_nums(num1,num2,double + double, shifts + 1)
end

# p multiply_nums(3,17,1,0)

# Write a method to compute all permutations of a string of unique characters
# without dups
