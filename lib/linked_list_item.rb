class LinkedListItem
  include Comparable
  attr_reader :next_list_item
  attr_accessor :payload
  def initialize(payload)
    @payload = payload
    @next_list_item = nil
  end

  def next_list_item= object
    if object === self
      raise ArgumentError.new("Can't set self as next item")
    end
    @next_list_item = object
  end

  def last?
    @next_list_item.nil?
  end

  def <=> object
    return 1 if @payload.class == Symbol && object.payload.class != Symbol
    return -1 if @payload.class != Symbol && object.payload.class == Symbol
    @payload.to_s <=> object.payload.to_s
  end

  def === object
    self.object_id == object.object_id
  end

end