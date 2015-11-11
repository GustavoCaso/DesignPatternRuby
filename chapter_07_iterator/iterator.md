## Reaching into a Collection with the Iterator

The iterator pattern is a tecnique that allow an aggregate object to provide the outside world with a way to access its collection of sub-objects.
We have to differenciate between **external iterator** and **internal iterators**

### External iterators

External because the iterator is a separate object from the aggregate.

```ruby
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

```

### Internal Iterator

The purpose odf the internal iterator is introduce your code to each sub-object of an aggregate object.

```ruby
def for_each_element(array)
  i = 0
  while i < array.length
    yield(array[i])
    i += 1
  end
end

a = [10, 20, 30]
for_each_element(a) {|element| puts("The element is #{element}")}

```

### Internal VS External

External have some advantages,by contrast, you won't call `next` until you are good and ready for the next element. With internal iterator, the aggregate relentlesly pushes the code block to accept item after item.
Other advantage of external iterators, because they are external you can share them, with other methods and objects.
The main thing the internal iterators have is simplicity and code clarity.
