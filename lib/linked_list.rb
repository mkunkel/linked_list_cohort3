require 'linked_list_item'

class LinkedList

  def initialize *args
    @first_node = nil
    for arg in args
      self.add_item(arg)
    end
  end

  def add_item object
    node = @first_node
    if node
      while node.next_list_item do
        node = node.next_list_item
      end
      node.next_list_item = LinkedListItem.new(object)
    else
      @first_node = LinkedListItem.new(object)
    end
  end

  def get index
    raise IndexError.new("Index must be positive") if index < 0
    raise IndexError.new("Linked list contains no items") unless @first_node
    node = @first_node
    for i in 0...index
      raise IndexError.new("Index out of range") unless node.next_list_item
      node = node.next_list_item
    end
    return node.payload
  end

  def indexOf object
    return nil unless @first_node
    node = @first_node
    index = 0
    while node.next_list_item do
      break if node.payload == object
      node = node.next_list_item
      index = index + 1
    end
    return node.payload == object ? index : nil
  end

  def [] index
    self.get(index)
  end

  def []= index, value
    raise IndexError.new("Index must be positive") if index < 0
    raise IndexError.new("Linked list contains no items") unless @first_node
    node = @first_node
    for i in 0...index
      raise IndexError.new("Index out of range") unless node.next_list_item
      node = node.next_list_item
    end
    node.payload = value
  end

  def remove index
    raise IndexError.new("Index must be positive") if index < 0
    raise IndexError.new("Linked list contains no items") unless @first_node
    node = @first_node
    for i in 0...index
      raise IndexError.new("Index out of range") unless node.next_list_item
      previous = node
      node = node.next_list_item
    end

    if node.next_list_item && previous
      previous.next_list_item = node.next_list_item
    elsif previous != node && previous
      previous.next_list_item = nil
    else
      @first_node = node.next_list_item ? node.next_list_item : nil
    end
  end

  def insert index, object
    raise IndexError.new("Index must be positive") if index < 0
    raise IndexError.new("Index too high") if index < self.size

  end

  def size
    node = @first_node
    return 0 unless node
    size = 1
    while node.next_list_item do
      if node.next_list_item
        node = node.next_list_item
        size = size + 1
      end
    end
    return size
  end

  def last
    return nil unless @first_node
    node = @first_node
    while node.next_list_item do
      if node.next_list_item
        node = node.next_list_item
      end
    end
    return node.payload
  end

  def to_s
    string = "| "

    return string + "|" unless @first_node


    node = @first_node
    strings = [node.payload.to_s]
    while node.next_list_item do
      if node.next_list_item
        node = node.next_list_item
      end
      strings.push(node.payload.to_s)
    end
    return string + strings.join(", ") + " |"
  end

  def sorted?
    return true unless @first_node
    node = @first_node
    object1 = node.payload
    while node.next_list_item do
      node = node.next_list_item
      object2 = node.payload

      sorted = object1.to_s <=> object2.to_s
      sorted = 1 if object1.is_a?(Symbol) && !object2.is_a?(String)
      return false if sorted == 1
    end
    return true
  end

  def sort
    size = self.size
    sorted = size == 0 ? true : false
    while !sorted
      sorted = true
      for i in 0...size - 1
        item1 = get(i)
        item2 = get(i+1)
        if item1.is_a?(Symbol) && !item2.is_a?(Symbol)
          swap_with_next(i)
          sorted = false
        elsif item1.to_s > item2.to_s && !item2.is_a?(Symbol)
          swap_with_next(i)
          sorted = false
        end

      end
    end
    return self
  end

  def swap_with_next index
    raise IndexError.new("Index must be positive") if index < 0
    raise IndexError.new("Linked list contains no items") unless @first_node
    node = @first_node
    for i in 0..index
      raise IndexError.new("Index out of range") unless node.next_list_item
      previous = node
      node = node.next_list_item
    end
    node.payload, previous.payload = previous.payload, node.payload
  end

end