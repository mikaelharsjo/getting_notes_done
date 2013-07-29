class Task
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter

  columns :name        => :string,
          :long_name   => :string,
          :due_date    => :date
end

describe 'Motion Model scratchpad' do
	it 'should exist' do
	    @task = Task.create :name => 'walk the dog',
	                :long_name    => 'get plenty of exercise. pick up the poop',
	                :due_date     => '2012-09-15'
	    task = Task.where(:name).eq('walk the dog')
	    task.count.should == 1
		task.first.name.should == @task.name
	end
end