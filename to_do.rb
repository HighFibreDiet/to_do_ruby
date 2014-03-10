require './lib/task'
require './lib/list'

@lists = []
@list_index = 1

def main_menu
  puts 'Press "n" to add a new list.'
  puts 'Press "l" to list all to do lists'
  puts 'Press "x" to exit'

  main_choice = gets.chomp

  case main_choice
  when 'n'
    puts "Please enter a description for your list: \n"
    list_description = gets.chomp
    new_list = List.new(list_description, @list_index)
    @list_index += 1
    @lists << new_list
    add_to_list(new_list)
  when 'l'
    list_lists
  when 'x'
    puts "Bye-bye!"
  else
    puts "That is not a valid input. Idiot."
    main_choice
  end
end

def add_to_list(list)
  puts "#{list.id}. #{list.description} - #{list.tasks.length} tasks"
  puts "To add a new task, press 'n'"
  puts "Press 'm' to see more options"
  add_choice = gets.chomp
  if add_choice == 'n'
    list.add_task(add_task(list.tasks.length + 1))
    add_to_list(list)
  elsif add_choice == 'm'
    list_tasks(list)
    edit_list(list)
  else
    'Idiot'
    add_to_list(list)
  end
end

def add_task(id)
  puts "Please enter a description for your task: \n"
  new_description = gets.chomp
  new_task = Task.new(new_description, id)
  puts "Please enter a due date for your task: \n"
  due_date = gets.chomp
  new_task.set_due_date(due_date)
  puts "Please enter a priority for your task: \n"
  priority = gets.chomp.to_i
  new_task.set_priority(priority)
  return new_task
end

def list_tasks(list)
  puts "Completed:\n"
  list.tasks.each do |task|
    if task.done?
      puts "#{task.id}. #{task.description}"
    end
  end
  puts "\n"
  puts "Incomplete:\n"
  list.tasks.each do |task|
    if !task.done?
      puts "#{task.id}. #{task.description} - #{task.due_date} - Priority #{task.priority}"
    end
  end
  puts "\n"
  puts "\n"
end

def list_lists
  @lists.each do |list|
    puts "#{list.id}. #{list.description} - #{list.tasks.length} tasks"
  end
  puts "Press 'm' to return to main menu and create a new list."
  puts "Enter list ID to view, edit a list."

  choice = gets.chomp

  if choice == 'm'
    main_menu
  elsif choice.to_i <= @lists.length
    @lists.each do |list|
      if list.id == choice.to_i
        add_to_list(list)
      end
    end
    puts "\n"
  else
    puts "Idiot"
    puts "\n"
    list_lists
  end
end

def edit_list(list)
  puts "To edit a task, enter the ID."
  puts "To return to the main menu, press 'm'."
  puts "Press 'sp' to sort by priority \n"
  puts "Press 'sd' to sort by description \n"

  list_choice = gets.chomp
  puts "\n"

  if list_choice == 'm'
    main_menu
  elsif list_choice == 'sp'
    list.priority_sort
    list_tasks(list)
  elsif list_choice == 'sd'
    list.name_sort
    list_tasks(list)
  elsif list_choice.to_i <= list.tasks.length
    task_menu(list, list_choice.to_i)
    puts "\n"
  else
    puts "That was not a valid choice, dumbass"
    list_tasks(list)
    edit_list(list)
    puts "\n"
  end
end

def task_menu(list, id)
  current_task = Task.new("")
  list.tasks.each do |task|
    if task.id == id
      current_task = task
    end
  end

  puts "Task: #{current_task.description} Due date: #{current_task.due_date} Priority: #{current_task.priority}"
  puts "\n"
  puts "Press 'c' to mark the task complete."
  puts "Press 'd' to set a new due date."
  puts "Press 'p' to change the priority."
  puts "Press 'm' to return to the main menu."
  puts "Press 'r' to remove the task."

  puts "\n"

  task_choice = gets.chomp

  if task_choice == 'm'
    main_menu
  elsif task_choice != 'd' && task_choice != 'c' && task_choice != 'p' && task_choice != 'r'
    puts "That was still not a valid choice. You are bad at this."
    task_menu(list,id)
    puts "\n"
  else
    if task_choice == 'c'
      current_task.mark_done
      puts "Marked complete."
      puts "\n"
    elsif task_choice == 'r'
      list.delete_task(current_task)
    elsif task_choice == 'd'
      puts "Please enter a due date: \n"
      new_due_date = gets.chomp
      current_task.set_due_date(new_due_date)
    else
      puts "Please enter a new priority: \n"
      new_priority = gets.chomp.to_i
      current_task.set_priority(new_priority)
    end
  list_tasks(list)
  edit_list(list)
  puts "\n"
  end
end

main_menu
