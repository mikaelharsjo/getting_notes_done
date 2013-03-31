class WhenViewController < ContextViewController
	def viewDidLoad
		@title = 'When?'
		@next = 'Who?'
		@tags = ['Daily', 'Next', 'Soon']
		super
	end

end