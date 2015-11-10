## Picking the Right Class with a Factory

Imagine that we have a problem where our PM ask us to create a `Pond` simulator. We think for ourself, thats easy.
We decided to create a `Duck` class.
```ruby
class Duck
  def initialize(name)
    @name = name
  end

  def eat
    puts("Duck #{@name} is eating.")
  end

  def speak
    puts("Duck #{@name} says Quack!")
  end

  def sleep
    puts("Duck #{@name} sleeps quietly.")
  end
end
```
So from this code most of the animals will `sleep`, `eat` and `speak` a simple interface.
After that hard work we create the `Pond` class.
```ruby
class Pond
  def initialize(number_ducks)
    @ducks = []
    number_ducks.times do |i|
      duck = Duck.new("Duck#{i}")
      @ducks << duck
    end
  end

  def simulate_one_day
    @ducks.each {|duck| duck.speak}
    @ducks.each {|duck| duck.eat}
    @ducks.each {|duck| duck.sleep}
  end
end
```
Super happy with our work, we decide to lay down for a while, when suddenly the PM strike again and ask us to introde a new animal to the `Pond`, this type is a `Frog`
```ruby
class Frog
  def initialize(name)
    @name = name
  end

  def eat
    puts("Frog #{@name} is eating.")
  end

  def speak
    puts("Frog #{@name} says Crooooaaaak!")
  end

  def sleep
    puts("Frog #{@name} doesn't sleep; he croaks all night!")
  end
end
```
But our `Pond` only counted with `Ducks` in the initialize method.

### The Template Method Strike Again

One way of dealing with **which class** problem is to push the question down onto a subclass. We atrt by building a generict class, in the sense that is not make the decision of **which class**, instead when ever needs a new a new object it relies on the **subclass** method.

```ruby
class Pond
  def initialize(number_animals)
    @animals = []
    number_animals.times do |i|
      animal = new_animal("Animal#{i}")
      @animals << animal
    end
  end

  def simulate_one_day
    @animals.each {|animal| animal.speak}
    @animals.each {|animal| animal.eat}
    @animals.each {|animal| animal.sleep}
  end
end
```

Now we can build two **subclasses**
```ruby
class DuckPond < Pond
  def new_animal(name)
    Duck.new(name)
  end
end

class FrogPond < Pond
  def new_animal(name)
    Frog.new(name)
  end
end
```

Also we could have created a **subclass** of `Pond` whose `new_animal` method produces a mix of both.
This technique of pushing down the decision on a **subclass** is the **Factory Pattern**

### Parameterized Factory Methods

One problem with successful programs is that they tend to attract an ever-increasing pile of requirements.
In our case the ask us to introduce `Plants`

```ruby
class Algae
  def initialize(name)
    @name = name
  end

  def grow
    puts("The Algae #{@name} soaks up the sun and grows")
  end
end

class WaterLily
  def initialize(name)
    @name = name
  end

  def grow
    puts("The water lily #{@name} floats, soaks up the sun, and grows")
  end
end
```

So we have to modify the `Pond` class:

```ruby
class Pond
  def initialize(number_animals, number_plants)
    @animals = []
    number_animals.times do |i|
      animal = new_animal("Animal#{i}")
      @animals << animal
    end
    @plants = []
    number_plants.times do |i|
      plant = new_plant("Plant#{i}")
      @plants << plant
    end
  end

  def simulate_one_day
    @plants.each {|plant| plant.grow }
    @animals.each {|animal| animal.speak}
    @animals.each {|animal| animal.eat}
    @animals.each {|animal| animal.sleep}
  end
end
```

Also our **subclasses*

```ruby
class DuckWaterLilyPond < Pond
  def new_animal(name)
    Duck.new(name)
  end

  def new_plant(name)
    WaterLily.new(name)
  end
end

class FrogAlgaePond < Pond
  def new_animal(name)
    Frog.new(name)
  end

  def new_plant(name)
      Algae.new(name)
  end
end
```

This techniques is getting out of hand. We have to separate method for each type of object, this way is not going to be very scalable.
A cleaner and perhaps better way is to have a single factory method that takes a parameter, and tell the method which kind of object to create **parameterized factory method**

This would be the implementation:

```ruby
class Pond
  def initialize(number_animals, number_plants)
    @animals = []
    number_animals.times do |i|
      animal = new_organism(:animal, "Animal#{i}")
      @animals << animal
    end
    @plants = []
    number_plants.times do |i|
      plant = new_organism(:plant, "Plant#{i}")
      @plants << plant
    end
  end
end

class DuckWaterLilyPond < Pond
  def new_organism(type, name)
    if type == :animal
      Duck.new(name)
    elsif type == :plant
      WaterLily.new(name)
    else
      raise "Unknown organism type: #{type}"
    end
  end
end
```

### Classes Are Just Objects, Too

One pattern as we have written it so far is that this pattern require a separate subclass for each specific type of object that needs to be manufactured.
The thing to realize is that the `Frog`, `Duck`, `WaterLily`, and `Algae` classes are just objects. We can get rid of this whole hierarchy of `Pond` subclass by storing the classes of the objects that we want to create in instance variables.

```ruby
class Pond
  def initialize(number_animals, animal_class, number_plants, plant_class)
    @animal_class = animal_class
    @plant_class = plant_class

    @animals = []
    number_animals.times do |i|
      @animals << new_organism(:animal, "Animal#{i}")
    end

    @plants = []
    number_plants.times do |i|
      @plants << new_organism(:plant, "Plant#{i}")
    end
  end

  def simulate_one_day
      @plants.each {|plant| plant.grow}
      @animals.each {|animal| animal.speak}
      @animals.each {|animal| animal.eat}
      @animals.each {|animal| animal.sleep}
  end

  def new_organism(type, name)
    if type == :animal
      @animal_class.new(name)
    elsif type == :plant
      @plant_class.new(name)
    else
      raise "Unknown organism type: #{type}"
    end
  end
end
```
This implementation is geting much better, but what happens when this program get into the wild, and we have to create `Jungles`, `Zoos` or what ever that we come into our minds.
We can relay on some pattern **abstarct factory** that is an object that single responsability is how to create a consistent set of products.

Our code has evolve and now instead of having `Pond` class we have `Habitat` class that is to improve our code decision name.

We will create to **abstract factory**:

```ruby
class PondOrganismFactory
  def new_animal(name)
    Frog.new(name)
  end

  def new_plant(name)
    Algae.new(name)
  end
end

class JungleOrganismFactory
  def new_animal(name)
    Tiger.new(name)
  end

  def new_plant(name)
    Tree.new(name)
  end
end
```
We a little modification in our `Habitat` initialize method we can use our **abstract factory**

```ruby
class Habitat
  def initialize(number_animals, number_plants, organism_factory)
    @organism_factory = organism_factory

    @animals = []
    number_animals.times do |i|
      animal = @organism_factory.new_animal("Animal#{i}")
      @animals << animal
    end
    @plants = []
    number_plants.times do |i|
      plant = @organism_factory.new_plant("Plant#{i}")
      @plants << plant
    end
  end
end

jungle = Habitat.new(1, 4, JungleOrganismFactory.new)
jungle.simulate_one_day
pond = Habitat.new( 2, 4, PondOrganismFactory.new)
pond.simulate_one_day
```

