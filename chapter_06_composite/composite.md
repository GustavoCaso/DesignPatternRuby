## Composite Pattern

The composite pattern suggests that we build bigger objects from smaller onjects.

In this example we are going to Manufacture a cake from smaller task. Remenber not to subdivide the process into really small task. That will create a really complicated composition.

All of the `class` or `task` will have to share an interface,
for our example we are going to use a common class `Task`so every simple task `AddDryIngredientsTask`, `AddLiquidTask` have the same interface, there are more complex task, that are the result of combining multiple task.

#### Create Composites

You will know tha you need to use the **Composite** pattern when you are tring to build a hierarchy or tree of obects, and you don't want the code that uses the tree to constantly have to worry about whether it is dealing with a single object or a whole bushy branch of the tree.
To building the **Composite** pattern we need:
* Common interface or a base class for all of our objects
* We need one or more *leaf* classes that are the simplest individual tasks
* We need one higher level class or `composite` that is built up from small *leaf* class.

```ruby
# This will be our base class
class Task
  attr_reader :name
  attr_accessor :parent

  def initialize(name)
    @name = name
    @parent = nil
  end

  def get_time_required
    0.0
  end
end
```

```ruby
class AddDrayIngredientsTask < Task
  def initialize
    super('Add dry ingredients')
  end

  def get_time_required
    1.0
  end
end

class MixTask < Task
  def initialize
    super('Mix that batter up!')
  end

  def get_time_required
    3.0
  end
end
```

```ruby
class CompositeTask < Task
  def initialize(name)
    super(name)
    @sub_tasks = []
  end

  def <<(task)
    add_sub_task(task)
  end

  def [](index)
    @sub_tasks[index]
  end

  def []=(index, new_task)
    @sub_tasks[index] = new_task
  end

  def add_sub_task(task)
    @sub_tasks << task
    task.parent = self
  end

  def remove_sub_task(task)
    @sub_tasks.delete(task)
    task.parent = nil
  end

  def get_time_required
    time = 0.0
    @sub_tasks.each {|task|  time += task.get_time_required}
    time
  end
end
```

```ruby
class MakeButterTask < CompositeTask
  def initiallize
    super('Make Butter')
    add_sub_task(AddDrayIngredientsTask.new)
    add_sub_task(MixTask.new)
  end
end
```

In our example we created a base class `Task` and a more complex class `CompositeTask` but both have the same interface.

#### Sprucing Up the Composite with Operators

We are going to improve the inteface of our `composite` class with operators, like `<<` so we can add `Tasks` at run time if need, or `[i]` to decide in what position of the task list our sub task should be placed.

#### The point

With the composition patern we want that the `leaf` and the `composite` are the same, well almost the same, beacuse our `CompositeTask` have some methods that the `Task` do not have.
There are many eways of dealing with that, maybe you prefer that the `Task` class have all this method and just the `composite` objects use them, but what will happen if a `leaf` call it.
As I said that is up to you.

#### Saving the referende to teh parent
So fat the composite pattern as a strictly top-down affair. Because each object holds the reference to its subcomponents.
Adding a reference to the parent is simple, adding to the `Task` class and upadet everytime that we add a subtask.

#### Abusing the Composite

Their is only one really mistake with the composite pattern, is assuming that the tree is only one level deep, assuming all the child components od the coposite object are in fact leaf objects and not other composite
