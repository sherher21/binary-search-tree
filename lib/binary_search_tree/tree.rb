class Tree
  attr_accessor :root, :data
  def initialize(array = [])
    @data = sort(array & array)
    @root = build_tree(@data)
  end

  def build_tree(array)
    return nil if array.empty?
    mid = array.length / 2
    node = Node.new(array[mid])
    node.left = build_tree(array[0...mid])
    node.right = build_tree(array[mid+1..])
    return  node
  end

  def sort(array)
    for i in 1...array.length
      j = i
      while j > 0 && array[j - 1] > array[j]
        array[j], array[j - 1] = array[j - 1], array[j]
        j = j - 1 
      end
    end
    return array
  end

  def find(value, node = @root)
    return node if node.nil? || value == node.value 
    return find(value, node.right) if node.value < value
    return find(value, node.left)
  end

  def insert(value, node = @root)
    return @root = Node.new(value) if @root.nil?
    return nil if value == node.value

    if value < node.value
      nil == node.left ? node.left = Node.new(value) : insert(value, node.left)
    else
      nil == node.right ? node.right = Node.new(value) : insert(value, node.right)
    end
  end

  def delete(value, node = @root)
    return nil if node.nil?
    if value < node.value
      delete(value, node.left)
    elsif value > node.value
      delete(value, node.right)
    else
      return node.right if node.left.nil?
      return node.left if node.right.nil?
      unless node.left.nil? && node.right.nil?
        min_node = min(node.right)
        node.value = min_node.value
        node.right = delete(min_node.value, node.right)
      else
        node = nil
      end
    end
    node
  end

  def level_order
    return [] if @root.nil?
    queue = [@root]
    list = []
    until queue.empty?
      node = queue.shift
      block_given? ? yield(node) : list << node.value
      queue << node.left unless node.left.nil?
      queue << node.right unless node.right.nil?
    end
    list unless block_given?
  end

  # def level_order_rec(node = @root, queue = [], list = [])
  #   return queue if node.nil?
  #   queue << node
  #   unless queue.empty?
  #     node = queue.shift
  #     queue << node.left unless node.left.nil?    
  #     queue << node.right unless node.right.nil?
  #     block_given? ? yield(node) : list << node.value
  #     level_order_rec(queue.shift, queue, list)
  #   end
  #   list unless block_given?
  # end

  def preorder(node = @root, list = [])
    return if node.nil?
    block_given? ? yield(node) : list << node.value
    preorder(node.left, list)
    preorder(node.right, list)
    list unless block_given?
  end

  def inorder(node = @root, list = [])
    return if node.nil?
    inorder(node.left, list)
    block_given? ? yield(node) : list << node.value
    inorder(node.right, list)
    list unless block_given?
  end

  def postorder(node = @root, list = [])
    return if node.nil?
    postorder(node.left, list)
    postorder(node.right, list)
    block_given? ? yield(node) : list << node.value
    list unless block_given?
  end

  def height(node = @root)
    return 0 if node.nil?
    unless node.nil?
      left = height(node.left)
      right = height(node.right)
      left > right ? left + 1 : right + 1
    end
  end

  def depth(value, node = @root, edge = 0)
    return -1 if node.nil?
    return edge if value == node.value
    return depth(value, node.left, edge + 1) if value < node.value
    return depth(value, node.right, edge + 1) if value > node.value
  end

  def balanced?(node = @root, left = 0, right = 0)
    return true if node.nil?
    left = height(node.left) if node.left
    right = height(node.right) if node.right
    return (left - right).abs <= 1
  end

  def rebalance
    @root = build_tree(inorder())
  end

  def min(node)
    node = node.left until nil == node.left
    node
  end

  def max(node)
    node = node.right until nil == node.right
    node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    return if nil == node
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
