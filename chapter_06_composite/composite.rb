require './composite_task'
require './sub_tasks'

class MakeButterTask < CompositeTask
  def initiallize
    super('Make Butter')
    add_sub_task(AddDrayIngredientsTask.new)
    add_sub_task(MixTask.new)
  end
end
