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
    if self.root.nil? #if there is no root, this node will become root
      self.root = new_node
    else
      self.compare_place(self.root, new_node) #if there is already a root, we call the compare_place method to see if the new node should go to the left or right
    end
  end

  def compare_place(node1, node2)
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
    # return depth
  end

  def include?(score)
    node = self.root
    if node.score == score
      return true
    else
      next_include?(node, score)
    end
  end

  def next_include?(node, score)
    if node.score < score
      if node.right.nil?
        return false
      else
        node = node.right
        next_include?(node, score)
      end
    elsif node.score > score
      if node.left.nil?
        return false
      else
        node = node.left
        next_include?(node, score)
      end
    elsif node.score == score
      return true
    end
  end

  def depth_of
    #do 3rd
  end

  def max
    node = self.root
    until node.right.nil? #starting with root, find the farthest right value which will be the maximum score
      node = node.right
    end
    return {node.title => node.score} #once we find the farthest right (max), return the movie name and score as a hash
  end

  def min
    node = self.root
    until node.left.nil? #starting with root, find the farthest left value which will be the minimum score
      node = node.left
    end
    return {node.title => node.score} #once we find the farthest left (min), return the movie name and score as a hash
  end

  def sort
    #do last
  end

  def load
    #do last
  end

  def health
    #do last
  end

end

tree = BinarySearchTree.new

tree.insert(61, "Bill & Ted's Excellent Adventure")
tree.insert(16, "Johnny English")
tree.insert(92, "Sharknado 3")
tree.insert(50, "Hannibal Buress: Animal Furnace")

puts tree.max
puts tree.min

puts tree.include?(16)
puts tree.include?(72)
puts tree.include?(61)
puts tree.include?(54)
