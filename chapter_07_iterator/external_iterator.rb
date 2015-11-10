class ExternalIterator
  def initialize(object)
    @object = object
    @index = 0
  end

  def has_next?
    @index < @object.length
  end

  def item
    @object[@index]
  end

  def next_item
    value = @object[@index]
    @index += 1
    value
  end
end

array = %w{red green blue}

i = ExternalIterator.new(array)
while i.has_next?
  puts "#{i.next_item}"
end
