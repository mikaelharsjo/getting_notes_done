class Context
	attr_accessor :where

	def save
		NSUserDefaults.standardUserDefaults.setObject(@where, forKey: 'where')
	end

	def get
		@where = NSUserDefaults.standardUserDefaults.stringForKey 'where'
	end 
end