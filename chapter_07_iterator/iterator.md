## Reaching into a Collection with the Iterator

The iterator pattern is a tecnique that allow an aggregate object to provide the outside world with a way to access its collection of sub-objects.
We have to differenciate between **external iterator** and **internal iterators**

### External iterators

External because the iterator is a separate object from the aggregate.

### Internal Iterator

The purpose odf the internal iterator is introduce your code to each sub-object of an aggregate object.

### Internal VS External

External have some advantages,by contrast, you won't call `next` until you are good and ready for the next element. With internal iterator, the aggregate relentlesly pushes the code block to accept item after item.
Other advantage of external iterators, because they are external you can share them, with other methods and objects.
The main thing the internal iterators have is simplicity and code clarity.
