require 'rspec'
require 'list'
require './lib/task'

describe List do
  describe 'initialize' do
    it 'initializes a list object' do
      new_list = List.new('Llama things')
      new_list.should be_an_instance_of List
    end
    it 'sets the description' do
      new_list = List.new('Llama things')
      new_list.description.should eq 'Llama things'
    end
  end

  describe 'tasks' do
    it 'returns the task array' do
      test_list = List.new('Llama things')
      test_list.tasks.should eq []
    end
  end

  describe 'add_task' do
    it 'initializes a new task object' do
      test_list = List.new('Llama things')
      test_task = Task.new('bother the llama')
      test_list.add_task(test_task)
      test_list.tasks.should eq [test_task]
    end
  end
  describe 'priority_sort' do
    it 'sorts the tasks by priority' do
      test_list = List.new('Llama things')
      test_task = Task.new('bother the llama')
      test_task.set_priority(5)
      test_task2 = Task.new('pet the llama')
      test_task2.set_priority(2)
      test_list.add_task(test_task)
      test_list.add_task(test_task2)
      test_list.priority_sort
      test_list.tasks.should eq [test_task2, test_task]
    end
  end
  describe 'name_sort' do
    it 'sorts the tasks by description' do
      test_list = List.new('Llama things')
      test_task2 = Task.new('bother the llama')
      test_task  = Task.new('pet the llama')
      test_list.add_task(test_task)
      test_list.add_task(test_task2)
      test_list.name_sort
      test_list.tasks.should eq [test_task2, test_task]
    end
  end
  describe 'delete_task' do
    it 'deletes a specific task from the tasks array' do
      test_list = List.new('Llama things')
      test_task2 = Task.new('bother the llama', 1)
      test_task  = Task.new('pet the llama', 2)
      test_list.add_task(test_task)
      test_list.add_task(test_task2)
      test_list.delete_task(test_task2)
      test_list.tasks.should eq [test_task]
    end
  end

end
