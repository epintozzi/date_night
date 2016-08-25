require './lib/date_night.rb'
require 'minitest/autorun'
require 'minitest/pride'

class BinarySearchTreeTest < Minitest::Test


  def test_it_returns_depth_when_inserted
    tree = BinarySearchTree.new

    assert_equal 0, tree.insert(61, "Bill & Ted's Excellent Adventure")
    assert_equal 1, tree.insert(16, "Johnny English")
    assert_equal 2, tree.insert(50, "Hannibal Buress: Animal Furnace")
  end

  def test_find_if_score_is_included
    tree = BinarySearchTree.new

    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")

    assert_equal true, tree.include?(16)
  end

  def test_it_returns_false_when_score_not_included
    tree = BinarySearchTree.new

    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")

    assert_equal false, tree.include?(72)
  end

  def test_include_returns_false_when_empty
    tree = BinarySearchTree.new

    assert_equal false, tree.include?(72)
  end

  def test_it_can_show_the_depth
    tree = BinarySearchTree.new

    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(50, "Hannibal Buress: Animal Furnace")

    assert_equal 1, tree.depth_of(16)
    assert_equal 0, tree.depth_of(61)
    assert_equal 2, tree.depth_of(50)
  end

  def test_it_returns_nil_for_depth_if_no_score
    tree = BinarySearchTree.new

    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")

    assert_equal nil, tree.depth_of(72)
  end

  def test_it_returns_nil_for_depth_if_tree_empty
    tree = BinarySearchTree.new

    assert_equal nil, tree.depth_of(72)
  end

  def test_it_returns_max_score
    tree = BinarySearchTree.new

    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")

    assert_equal ({"Sharknado 3" => 92}), tree.max
  end

  def test_it_returns_nil_if_empty_for_max_score
    tree = BinarySearchTree.new

    assert_equal nil, tree.max
  end

  def test_it_returns_min_score
    tree = BinarySearchTree.new

    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")

    assert_equal ({"Johnny English" => 16}), tree.min
  end

  def test_it_returns_nil_if_empty_for_min_score
    tree = BinarySearchTree.new

    assert_equal nil, tree.min
  end

  def test_it_inserts_movies_upon_load
    tree = BinarySearchTree.new

    assert_equal 99, tree.load("lib/movies.txt")
    assert_equal true, tree.include?(55)
  end

  def test_it_does_not_insert_duplicates_from_file
    tree = BinarySearchTree.new

    tree.insert(17, "Meet My Valentine")

    assert_equal 98, tree.load("lib/movies.txt")
  end

  def test_it_sorts_by_score
    tree = BinarySearchTree.new

    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")

    assert_equal [{"Johnny English" => 16}, {"Bill & Ted's Excellent Adventure" => 61}, {"Sharknado 3" => 92}], tree.sort

  end

  def test_it_returns_health
    tree = BinarySearchTree.new

    assert_equal [], tree.health(0)
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    assert_equal [], tree.health(1)
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress: Animal Furnace")

    assert_equal [[61, 4, 100]], tree.health(0)
    assert_equal [[16, 2, 50], [92, 1, 25]], tree.health(1)
  end


end
