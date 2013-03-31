class WhereViewController < ContextViewController
	def viewDidLoad
		@title = 'Where?'
		@next = 'When?'
		@tags = ['Home', 'Work', 'Away']
		super
	end

end