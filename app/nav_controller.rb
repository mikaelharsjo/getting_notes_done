class NavController < UIViewController
	include EvernoteHelpers

	def viewDidLoad
		view.backgroundColor = UIColor.whiteColor
		self.title = "Next actions"
		@label = UILabel.new
		@label.text = 'This is a list of actions that are actionable in the current context/location'
		@label.frame = [[50,50],[250,50]]
		view.addSubview(@label)

		@nav_add_button = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemAdd, target:self, action:'add_action')
		self.navigationItem.rightBarButtonItem = @nav_add_button 
	end

	def setupEvernote
		@session = EvernoteSession.sharedSession
		@note_store = EvernoteNoteStore.noteStore
		#first_time_setup = FirstTimeSetup.new @note_store		
		#first_time_setup.run()

		#@note_store.listTagsWithSuccess output_tags, failure: output_error
	end

	def output_tags
		lambda do |tags|
			tags.each {|tag| puts "#{tag.name} #{tag.parentGuid}"} 
		end
	end	

	def add_action
		add_action_controller = AddActionViewController.alloc.init
		self.navigationController.pushViewController(add_action_controller, animated:'YES')
	end
end