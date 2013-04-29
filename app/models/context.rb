class Context
	attr_accessor :where
	attr_accessor :what
	attr_accessor :when

	def save
		NSUserDefaults.standardUserDefaults.setObject :where, forKey: 'where'
		NSUserDefaults.standardUserDefaults.setObject :what, forKey: 'what'
		NSUserDefaults.standardUserDefaults.setObject :when, forKey: 'when'
	end

	def initialize
		@where = NSUserDefaults.standardUserDefaults.stringForKey 'where'
		@what = NSUserDefaults.standardUserDefaults.stringForKey 'what'
		@when = NSUserDefaults.standardUserDefaults.stringForKey 'when'
	end 
end