## Getting Things Done with Commands
Command pattern is common in GUIs, recording what we have done and finnaly we will see how to use the command pattern to undo things or redo things.

### Ours simple button example
We have a button that will behave differently depending on who implemented, it will do a sequence of commands. That where are we going to focus our attention the list of **Comands**
Basically our button will be waiting until someone press it, and will execute a list of commands.
Our `Commands` will have to implement some short of interface.
Depending on the bussiness logic you might what to store the `commands` in the `Button` class or maybe add the logic of the command at run time, easily achieve with a block, so we could pass a `proc` to the `Button` and execute it if present. This is usually if the action is fairly simple, but if the action or comand is complicated and you will need to carry around a lot o¡f state information or decompose into several methods, use the command class.

In the example we have created a bunch of commands `create`, `delete` and `copy`. Now we need a kind of frint to hold all the commands and add them and remove them, sound lilke `Composite`
so we create the `CompositeCommand`

```ruby
class Command
  attr_reader :description

  def initialize(description)
    @description = description
  end

  def execute; end
end
```

```ruby
class CreateFile < Command
  def initialize(path, contents)
    super("Create file: #{path}")
    @path = path
    @contents = contents
  end

  def execute
    File.write(@path, 'w') do |f|
      f.write(@contents)
    end
  end
end

class DeleteFile < Command
  def initialize(path)
    super("Delte this file #{path}")
    @path = path
  end

  def execute
    File.delete(@path)
  end
end

class CopyFile < Command
  def initialize(sorce, target)
    super("Copy file: #{source} to #{target}")
    @source = source
    @target = target
  end

  def execute
    FileUtils.copy(@source, @target)
  end
end
```

```ruby
class SlickButton
  attr_accessor: :command

  def initialize(command)
    @command = command
  end

  def on_button_push
    command.execute if @command
  end
end

class SlickButtonWithProc
  attr_accessor: :command

  def initialize(&block)
    @command = block
  end

  def on_button_push
    command.call if @command
  end
end

# new_button = SlickButton.new do
#   puts "Hello World"
# end
```

```ruby
class CompositeCommand < Command
  def initialize
    @commands = []
  end

  def add_command(cmd)
    @commands << cmd
  end

  def execute
    @commands.each(&:execute)
  end

  def unexecute
    @commands.reverse.each(&:unexecute)
  end

  def description
    @commands.map(&:description).join("\n")
  end
end


cmds = CompositeCommand.new
cmds.add_command(CreateFile.new('file1.txt', "hello world\n"))
cmds.add_command(CopyFile.new('file1.txt', 'file2.txt'))
cmds.add_command(DeleteFile.new('file1.txt'))

```

### Being Undone by a Command

Being able to undo is really common requirements in now a days.
The naive way to implemet this is by remenbering the state of thinkgs before the change.

So with this we could implement and interface where every command has the `execute` method and the `unexecute` method which unoes the same thing.  And we store the `Commands` in order.y


```ruby
class CreateFile < Command
  def initialize(path, contents)
    super("Create file: #{path}")
    @path = path
    @contents = contents
  end

  def execute
    File.write(@path, 'w') do |f|
      f.write(@contents)
    end
  end

  def unexecute
    File.delete(@path)
  end
end

class DeleteFile < Command
  def initialize(path)
    super("Delte this file #{path}")
    @path = path
  end

  def execute
    if File.exists?(@path)
      @contents = File.read(@path)
    end
    File.delete(@path)
  end

  def unexecute
    if @contens
      File.open(@path, 'w') do |f|
        f.write(@contents)
      end
    end
  end
end

class CopyFile < Command
  def initialize(sorce, target)
    super("Copy file: #{source} to #{target}")
    @source = source
    @target = target
  end

  def execute
    FileUtils.copy(@source, @target)
  end

  def unexecute
    FileUtils.copy(@target, @source)
  end
end
```

