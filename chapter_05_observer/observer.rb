# This pattern allow us to transforms as source of information, and the rest
# of the objects interested in listening, to keep up to date with the status of
# the object

class Employee
  attr_reader :name
  attr_accessor :title, :salary

  def initialize(name. title, salary)
    @name = name
    @title = title
    @salary = salary
  end
end

# One way of notify to the Payment object will be given the by the attr_accessor
# of salary, overwritting it

class Payroll
  def update(employee)
    puts "#{employee.name} got his check"
  end
end

class Employee
  attr_reader :name, :title, :salary

  def initialize(name. title, salary)
    @name = name
    @title = title
    @salary = salary
  end

  def salary= (value)
    @salary = value
    @payroll.update(self)
  end
end

# payroll = Payroll.new
# fred = Employee.new('Fred', 'Crane Operator', 30000, payroll)
# fred.salary = 35000

# As right now the code is really hard-wire, and will need to constanly update
# the Employee class to add new Departments, there has to be a better way
# by keep a list of objects interested in the Employee changes

class Employee
  attr_reader :name, :title, :salary

  def initialize(name, title, salary)
    @name = name
    @title = title
    @salary = salary
    @observers = []
  end

  def salary= (value)
    @salary = value
    notify_observers
  end

  def add_observer(observer)
    @observers << observer
  end

  def remove_observer(observer)
    @observers.delete(observer)
  end

  private

  def notify_observers
    @observers.each do |ob|
      ob.update(self)
    end
  end
end

# fred = Employee.new('Fred', 'Crane Operator', 30000.0)
# payroll = Payroll.new
# fred.add_observer( payroll )
# fred.salary=35000.0

# By doing this way we have removed the coupling between the Employee class
# and the Payroll class


