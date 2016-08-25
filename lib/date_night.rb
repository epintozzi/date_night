class Node
  attr_accessor :left, :right, :score, :title
  def initialize(score, title)
    @score = score
    @title = title
  end
end

class BinarySearchTree
  attr_accessor :root

  def insert(score, title)
    new_node = Node.new(score, title)
    @depth = 0
    if self.root.nil? #if there is no root, this node will become root
      self.root = new_node
    else
      self.compare_place(self.root, new_node) #if there is already a root, we call the compare_place method to see if the new node should go to the left or right
    end
    return @depth
  end

  def compare_place(node1, node2)
    @depth += 1 #increment the node's depth every time compare_place is called on that node
    if node2.score < node1.score #checks if node 2 is less than node 1
      if node1.left.nil? #if node 1 had nothing assigned to the left, node 2 will take that place
        node1.left = node2
      else
        compare_place(node1.left,node2) #if node 1 already has a left value, it will compare node 2 to the existing left node
      end
    else
      if node1.right.nil? #if node 2 is greater than node 1, we check to see if node1 has anything assigned to the right
        node1.right = node2 #if node 1 has nothing assigned to the right, node 2 will take that place
      else
        compare_place(node1.right, node2) #if node 1 already has something to the right, we compare node 2 to the existing right node
      end
    end
    return @depth
  end

  def include?(score)
    if self.root == nil #if the tree is empty, return nil
      return false
    end
    node = self.root
    if node.score == score #checks if the node's score is equal to the given score, returns true
      return true
    else
      next_include?(node, score) #if the node's score is not equal to the given score, run the next_include method to compare against next node
    end
  end

  def next_include?(node, score)
    if node.score < score #checks if the node's score is less than the given score
      if node.right.nil? #if node's score is less than given score, check if it has a right node assigned
        return false
      else
        node = node.right
        next_include?(node, score) #calls next_include method again until we run out of right nodes
      end
    elsif node.score > score #checks if the node's score is greater than the given score
      if node.left.nil? #if node's score is greater than given score, check if it has a left node assigned
        return false
      else
        node = node.left
        next_include?(node, score) #calls next_include method again until we run out of left nodes
      end
    elsif node.score == score
      return true
    end
  end

  def depth_of(score)
    if self.root == nil
      return nil
    end
    node = self.root
    @depth = 0
    if node.score != score
      depth_count(node,score)
    end
    return @depth
  end

  def depth_count(node, score)

    if node.score < score
      if node.right.nil?
        @depth = nil
      else
        node = node.right
        @depth += 1
        depth_count(node, score)
      end
    elsif node.score > score
      if node.left.nil?
        @depth = nil
      else
        node = node.left
        @depth += 1
        depth_count(node, score)
      end
    elsif node.score == score
      return @depth
    end
  end

  def max
    if self.root == nil
      return nil
    end
    node = self.root
    until node.right.nil? #starting with root, find the farthest right value which will be the maximum score
      node = node.right
    end
    return {node.title => node.score} #once we find the farthest right (max), return the movie name and score as a hash
  end

  def min
    if self.root == nil
      return nil
    end
    node = self.root
    until node.left.nil? #starting with root, find the farthest left value which will be the minimum score
      node = node.left
    end
    return {node.title => node.score} #once we find the farthest left (min), return the movie name and score as a hash
  end

  def load(file)
    movies = File.readlines(file)
    @num_added = 0
    movies.each do |movie|
      movie_array = movie.split(",")
      if include?(movie_array[0].to_i)
      else
        insert(movie_array[0].to_i, movie_array[1])
        @num_added += 1
      end
    end
    return @num_added
  end

  def sort
    sorted = []

    sorted.insert(0, min)
    sorted.insert(1, max)

    sorted
  end


  def health(depth)
    if self.root == nil
      return nil
    end

    if depth == 0
      nodes = [self.root]
      health = []
      nodes.each do |node|
        health << [node.score, 1 + num_children(node), percentage(node)]
      end
    end

    if depth == 1
      node = self.root
      nodes = [node.left, node.right]
      health = []
      nodes.each do |node|
        health <<[node.score, 1 + num_children(node), percentage(node)]
      end
    end
    health
  end

  def num_children(node = self.root)
    if node.left == nil and node.right == nil
      return 0
    end
    if node.left != nil and node.right == nil
      return 1 + num_children(node.left)
    end
    if node.left == nil and node.right != nil
      return 1 + num_children(node.right)
    end
    if node.left != nil and node.right != nil
      return 2 + num_children(node.left) + num_children(node.right)
    end
  end

  def num_nodes
    num_children + 1
  end

  def percentage(node)
    percentage = (((1.0 + num_children(node))/num_nodes)*100.0).to_i
  end

end

tree = BinarySearchTree.new

tree.insert(61, "Bill & Ted's Excellent Adventure")
tree.insert(16, "Johnny English")
tree.insert(92, "Sharknado 3")
tree.insert(50, "Hannibal Buress: Animal Furnace")

require 'json'

puts tree.sort.to_json

puts tree.health(1).to_json

# puts tree.depth_of(92)
# puts tree.load("lib/movies.txt")
# #
# # puts tree.max
# # puts tree.min
# #
# puts tree.include?(38)
# puts tree.include?(72)
# puts tree.include?(61)
# puts tree.include?(54)
