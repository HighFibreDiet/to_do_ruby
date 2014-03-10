require './lib/task'

@tasks = []
@index = 0

def main_menu
  puts 'Press "n" to add a new task.'
  puts 'Press "l" to list all tasks'
  puts 'Press "x" to exit'

  main_choice = gets.chomp

  case main_choice
  when 'n'
    add_task
  when 'l'
    list_tasks
  when 'x'
    puts "Bye-bye!"
  else
    puts "That is not a valid input. Idiot."
    main_choice
  end
end

def add_task
  puts "Please enter a description for your task: \n"
  new_description = gets.chomp
  new_task = Task.new(new_description, @index + 1)
  @index += 1
  puts "Please enter a due date for your task: \n"
  due_date = gets.chomp
  new_task.set_due_date(due_date)
  @tasks << new_task

  main_menu
end

def list_tasks
  puts "Completed:\n"
  @tasks.each do |task|
    if task.done?
      puts "#{task.id}. #{task.description}"
    end
  end
  puts "Incomplete:\n"
  @tasks.each do |task|
    if !task.done?
      puts "#{task.id}. #{task.description} - #{task.due_date}"
    end
  end
  list_menu
end

def list_menu
  puts "To edit a task, enter the ID.\n"
  puts "To return to the main menu, press 'm'."
  list_choice = gets.chomp

  if list_choice == 'm'
    main_menu
  elsif list_choice.to_i <= @index + 1
    task_menu(list_choice.to_i)
  else
    puts "That was not a valid choice, dumbass"
    list_tasks
    list_menu
  end
end

def task_menu(id)
  current_task = Task.new("")
  @tasks.each do |task|
    if task.id == id
      current_task = task
    end
  end

  puts "Task: #{current_task.description} Due date: #{current_task.due_date}"
  puts "Press 'c' to mark the task complete."
  puts "Press 'd' to set a new due date."
  puts "Press 'm' to return to the main menu."

  task_choice = gets.chomp

  if task_choice == 'm'
    main_menu
  elsif task_choice != 'd' && task_choice != 'c'
    puts "That was still not a valid choice. You are bad at this."
    task_menu(id)
  else
    if task_choice == 'c'
      current_task.mark_done
      puts "Marked complete."
    else
      puts "Please enter a due date: \n"
      new_due_date = gets.chomp
      current_task.set_due_date(new_due_date)
    end
  list_tasks
  list_menu
  end
end

main_menu
