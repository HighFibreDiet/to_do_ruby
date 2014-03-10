require 'rspec'
require 'task'

describe Task do
  describe 'initialize' do
    it 'initializes a task object with a description' do
      test_task = Task.new('wash the llama')
      test_task.should be_an_instance_of Task
    end
  end
  describe 'set_due_date' do
    it 'sets the due date based on the argument passed' do
      test_task = Task.new('brush the llama')
      test_task.set_due_date('4/1/14')
      test_task.due_date.should eq '4/1/14'
    end
  end
  describe 'description' do
    it 'returns the description' do
      test_task = Task.new('bother the llama')
      test_task.description.should eq 'bother the llama'
    end
  end

end
