
class List
  def initialize(description, index = 0)
    @description = description
    @id = index
    @tasks = []
  end

  def id
    @id
  end

  def description
    @description
  end

  def add_task(task)
    @tasks << task
  end

  def tasks
    @tasks
  end

  def priority_sort
    @tasks.sort! {|a, b| a.priority <=> b.priority}
  end

  def name_sort
    @tasks.sort! {|a, b| a.description <=> b.description}
  end

  def due_date_sort
    @tasks.sort! {|a, b| a.due_date <=> b.due_date}
  end

  def delete_task(delete_task)
    @tasks.delete_if {|task| task.id == delete_task.id}
  end
end



