class Context
	attr_accessor :where
	attr_accessor :what
	attr_accessor :when

	def save
		NSUserDefaults.standardUserDefaults['where'] = @where
		NSUserDefaults.standardUserDefaults['what'] = @what
		NSUserDefaults.standardUserDefaults['when'] = @when
	end

	def initialize
		@where = NSUserDefaults.standardUserDefaults['where']
		@what = NSUserDefaults.standardUserDefaults['what']
		@when = NSUserDefaults.standardUserDefaults['when']
	end
end