class Task
  def initialize(description, index = 0)
    @description = description
    @done = false
    @id = index
    @priority = 1
  end

  def id
    @id
  end

  def set_due_date(date)
    @due_date = date
  end

  def due_date
    @due_date
  end

  def set_priority(priority)
    @priority = priority
  end

  def priority
    @priority
  end

  def done?
    @done
  end

  def mark_done
    @done = true
  end

  def description
    @description
  end
end

