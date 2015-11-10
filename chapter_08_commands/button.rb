class SlickButtonWithProc
  attr_accessor: :command

  def initialize(&block)
    @command = block
  end

  def on_button_push
    command.call if @command
  end
end

new_button = SlickButton.new do
  puts "Hello World"
end

class SlickButton
  attr_accessor: :command

  def initialize(command)
    @command = command
  end

  def on_button_push
    command.execute if @command
  end
end

class SaveCommand
  def execute; end
end
