## Making Sure There Is Only One With the Singleton

In programming there are somethings that are unique. Like configuration files, a single log
file, GUI programs have one main window.
That is when the **singleton** pattern comes handy, a class that can have only one instance and that provides global acess to that one.

There are many ways you can get some of that **singleton** behavior in your code.

### Class Variables and Methods

Creating a *class variable* is really simple just is a variable with `@@`.
```ruby
class Test
  @@class_variable = 'Hello'
end
```
One of the peculiar things about *class variables* is that the value is shared across all the instances of the class.

Creating *class methods* is pretty straight forward, just knowing that inside a class `self` represent tha class we are defining, we can define methods to the class it**self**
```ruby
class Test
  def self.class_method
    puts 'Hello'
  end
end
```
### A Frisrt Try at a Ruby Singleton

The whole point of the singleton pattern is to avoid passing around instance of the class, for example in this logger class, we are going to use always the same instance, by using **class variables & class methods**
```ruby
class SingletonLogger
  @@instance = SingletonLogger.new

  def self.instance
    return @@instance
  end

  private_class_method :new
end
```
Does not care how many time do we call it, we are going to get the same `instance`.

### The Singleton Module

Wait but `Ruby` have our back, what if we have to repeat this process for another class, or a hundred more **o_O**.
`Ruby` includes a `Singleton` module.
```ruby
require 'singleton'

class SingletonLogger
  include Singleton
end
```

### Lazy and Eager Singletons

There is one difference between our implementation or the one from `Ruby` module.
In out example, even if the class is never use we actually create an instance of the same, that is called **eager instatiation**, but the `Singleton` module waits until someone calls `instance` before it actually creates its singleton, this technique is called **lazy instantiation**

