## Easier Object Construction with the Builder

This pattern is designed to help configure complex objects. There is a bit of overlap between **builders** and **factories**


###Building Computers

We will be writting a system that a small computer manufacturing business. Each machine is custom made to order, so you need to keep track of the components taht will go into each machine.

```ruby
class Computer
  attr_accessor :display, :motherboard
  attr_reader   :drives

  def initialize(display=:crt, motherboard=Motherboard.new, drives=[])
    @motherboard = motherboard
    @drives = drives
    @display = display
  end
end
```

The display is easy either :crt or :lcd. The motherboard is whole new object itself, it has a certain of memory and holds either an ordinary CPU or a superfast turbo processor:

```ruby
class CPU
  # Common CPU stuff...
end

class BasicCPU < CPU
  # Lots of not very fast CPU-related stuff...
end

class TurboCPU < CPU
  # Lots of very fast CPU stuff...
end

class Motherboard
  attr_accessor :memory_size, :cpu

  def initialize(cpu=BasicCPU.new, memory_size=1000)
      @cpu = cpu
      @memory_size = memory_size
  end
end
```

The drives, which come in three flavors are modeled by the Drive Class.

```ruby
class Drive
  attr_reader :type # either :hard_disk, :cd or :dvd
  attr_reader :size # in MB
  attr_reader :writable # true if this drive is writable

  def initialize(type, size, writable)
    @type = type
    @size = size
    @writable = writable
  end
end
```

Even with this somewhat simplified model of, constructing a new instance of `Computer` is paintfully tedious:
```ruby
motherboard = Motherboard.new(TurboCPU.new, 4000)
drives = []
drives << Drive.new(:hard_drive, 200000, true)
drives << Drive.new(:cd, 760, true)
drives << Drive.new(:dvd, 4700, false)
computer = Computer.new(:lcd, motherboard, drives)
```
The very simple idea behind the **Builder** pattern is that you take this kind of construction logic and encapsulate it in a class. The **Builder** class takes charge of assembling all of teh components of a complex object.

Each **builder** has an interface that lets you specify the configuration of your new object step by step, in a sense is like a multipart `new`

```ruby
class ComputerBuilder
  attr_reader :computer
  def initialize
    @computer = Computer.new
  end

  def turbo(has_turbo_cpu=true)
    @computer.motherboard.cpu = TurboCPU.new
  end

  def display=(display)
    @computer.display=display
  end

  def memory_size=(size_in_mb)
    @computer.motherboard.memory_size = size_in_mb
  end

  def add_cd(writer=false)
    @computer.drives << Drive.new(:cd, 760, writer)
  end

  def add_dvd(writer=false)
    @computer.drives << Drive.new(:dvd, 4000, writer)
  end

  def add_hard_disk(size_in_mb)
    @computer.drives << Drive.new(:hard_disk, size_in_mb, true)
  end
end
```

###Polymorphic Builders

This chapter began by contrasting the **Builder** pattern with the **Factories** and saying that **builders** are less concerned about picking the right class and more focused on helping you configure your object.
Nevertheless, given that builders are involved in object construction, they also are increidebly convenient spots to make those `which class` decisions.

Now we are growing as a company and we atrt assembilng `Laptops` the components for the `Laptop` are not the same.
We can refactor our **Builder** so we create a base class that deals with the details that are the same for both of them.

```ruby
class DesktopComputer < Computer
  # Lots of interesting desktop details omitted...
end

class LaptopComputer < Computer
  def initialize( motherboard=Motherboard.new,  drives=[] )
    super(:lcd, motherboard, drives)
  end
  # Lots of interesting laptop details omitted...
end
```

```ruby
class ComputerBuilder
  attr_reader :computer
  def turbo(has_turbo_cpu=true)
    @computer.motherboard.cpu = TurboCPU.new
  end
  def memory_size=(size_in_mb)
    @computer.motherboard.memory_size = size_in_mb
  end
end

class DesktopBuilder < ComputerBuilder
  def initialize
    @computer = DesktopComputer.new
  end

  def display=(display)
    @display = display
  end

  def add_cd(writer=false)
    @computer.drives << Drive.new(:cd, 760, writer)
  end

  def add_dvd(writer=false)
    @computer.drives << Drive.new(:dvd, 4000, writer)
  end

  def add_hard_disk(size_in_mb)
    @computer.drives << Drive.new(:hard_disk, size_in_mb, true)
  end
end

class LaptopBuilder < ComputerBuilder
  def initialize
    @computer = LaptopComputer.new
  end
  def display=(display)
    raise "Laptop display must be lcd" unless display == :lcd
  end

  def add_cd(writer=false)
    @computer.drives << LaptopDrive.new(:cd, 760, writer)
  end

  def add_dvd(writer=false)
    @computer.drives << LaptopDrive.new(:dvd, 4000, writer)
  end

  def add_hard_disk(size_in_mb)
    @computer.drives << LaptopDrive.new(:hard_disk, size_in_mb, true)
  end
end
```
