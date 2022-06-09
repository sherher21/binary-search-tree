class Node
  include Comparable
  attr_accessor :left, :right, :value
  
  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end

  def <=>(other)
    value <=> other.value if !value.nil? && !other.value.nil?
  end

end
