# frozen_string_literal: true

class Node
  attr_accessor :data, :left, :right

  def initialize(data = nil, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end
end

class Tree
  attr_accessor :data, :left, :right, :root

  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array)
    array = array.uniq.sort
    root = Node.new(array[array.size / 2])
    return root if array.size.zero?

    root.left = build_tree(array[0...array.size / 2])
    root.right = build_tree(array[array.size / 2 + 1...array.size])
    root
  end

  def find(value, node = root)
    return node if node.nil? || node.data == value

    if value < node.data
      find(value, node.left)
    else
      find(value, node.right)
    end
  end

  def insert(value, node = root)
    return nil if value == node.data

    if value < node.data
      node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
    else
      node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
    end
  end

  def level_order
    array = []
    queue = Queue.new
    queue << root
    until queue.empty?
      pop = queue.pop
      next if pop.nil?

      queue << pop.left
      queue << pop.right
      array.append(pop.data) unless pop.data.nil?
    end
    array
  end

  def preorder(node = root)
    return if node.nil?

    print node.data
    print ' '
    preorder(node.left)
    preorder(node.right)
  end

  def inorder(node = root)
    return if node.nil?

    inorder(node.left)
    print node.data
    print ' '
    inorder(node.right)
  end

  def postorder(node = root)
    return if node.nil?

    postorder(node.left)
    postorder(node.right)
    print node.data
    print ' '
  end

  def depth(node)
    height(@root) - height(node)
  end

  def height(node = root)
    return 0 if node.nil?

    left = node.left ? height(node.left) : 0
    right = node.right ? height(node.right) : 0
    [left, right].max + 1
  end

  def balanced?(root = @root)
    return true if root.nil?
    return true if balanced?(root.left) &&
                   balanced?(root.right) &&
                   (height(root.left) - height(root.right)).abs <= 1

    false
  end

  def rebalance
    @root = build_tree(level_order)
  end
end

tree = Tree.new(Array.new(100) { rand(1..100) })
puts tree.balanced?
puts tree.level_order
tree.preorder
puts
tree.inorder
puts
tree.postorder
puts
