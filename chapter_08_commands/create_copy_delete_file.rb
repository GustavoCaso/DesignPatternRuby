require './command'

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
