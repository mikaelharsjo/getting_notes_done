class NextActionsController < UITableViewController
	stylesheet :main_screen
	attr_reader :tags

	include EvernoteHelpers

	def viewDidLoad
		@filter = Filter.new @tags
		
		view.backgroundColor = UIColor.whiteColor
		self.title = "Next actions"
		@notes = Array.new

		image_view = UIImageView.alloc.initWithImage(UIImage.imageNamed('images/notes_table_bg.png'))
		self.tableView.backgroundView = image_view

		self.refreshControl = UIRefreshControl.alloc.init
		self.refreshControl.addTarget self, action: 'load_actions_from_evernote', forControlEvents: UIControlEventValueChanged

		nav_add_button = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemAdd, target: self, action: 'add_action')
		self.navigationItem.rightBarButtonItem = nav_add_button

		load_actions_from_evernote
	end

	def load_actions_from_evernote
		self.refreshControl.beginRefreshing
		@session = EvernoteSession.sharedSession
		@note_store = EvernoteNoteStore.noteStore
		filter = EDAMNoteFilter.alloc.initWithOrder 0, ascending:false, words:nil, notebookGuid:nil, tagGuids:nil, timeZone:nil, inactive:false, emphasized:nil

		spec = EDAMNotesMetadataResultSpec.alloc.initWithIncludeTitle true, includeContentLength:false, includeCreated:false, includeUpdated:false, includeUpdateSequenceNum:false, includeNotebookGuid:false, includeTagGuids:true, includeAttributes:false, includeLargestResourceMime:false, includeLargestResourceSize:false
		@note_store.findNotesMetadataWithFilter filter, offset:0, maxNotes:10, resultSpec:spec, success: notes_loaded, failure: output_error
	end

	def notes_loaded
		lambda do |meta_data|
			meta_data.notes.each do |note|
				new_note = Note.new(note.title)
				@notes << new_note
			end

			self.refreshControl.endRefreshing
			self.tableView.reloadData
		end
	end

	def tableView(tableView, cellForRowAtIndexPath: indexPath)
		@reuse_id_for_text_cell ||= "CELL_IDENTIFIER"
		@reuse_id_for_button_cell ||= "CELL_IDENTIFIER_BUTTON"

		text_cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
		  UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuse_id_for_text_cell)
		end

		button_cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
		  UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuse_id_for_text_cell)
		end

		checkbox_width = 25
		total_width = self.view.bounds.size.width
		label_rect = CGRectMake(60, 10, total_width - checkbox_width, 25)
		check_button_rect = CGRectMake(10, 6, checkbox_width, 25)

		label = UILabel.alloc.initWithFrame label_rect
		label.setFont UIFont.fontWithName('Inconsolata', size: 19)
		label.setText @notes[indexPath.row].title
		label.backgroundColor = UIColor.clearColor

		check_button = UIButton.buttonWithType UIButtonTypeRoundedRect
		check_button.backgroundColor = UIColor.clearColor
		checked_image = UIImage.imageNamed('images/glyphicons_152_check.png')
		check_button.setBackgroundImage UIImage.imageNamed('images/glyphicons_153_unchecked.png'), forState: UIControlStateNormal
		check_button.setBackgroundImage checked_image, forState: UIControlStateSelected
		check_button.setBackgroundImage checked_image, forState: UIControlStateHighlighted
		check_button.adjustsImageWhenHighlighted = true
		check_button.addTarget self, action: 'checkbox_selected:', forControlEvents: UIControlEventTouchUpInside
		check_button.frame = check_button_rect

		text_cell.contentView.addSubview check_button
		text_cell.contentView.addSubview label

		# put your data in the cell

		text_cell
	end

	def init_with_tags tags
		@tags = tags
		initWithNibName nil, bundle: nil
	end

 	def initWithNibName(name, bundle: bundle)
		super
		current_actions_image = UIImage.imageNamed 'images/glyphicons_193_circle_ok.png'
		change_context_image = UIImage.imageNamed 'images/glyphicons_370_globe_af.png'
		self.tabBarItem = UITabBarItem.alloc.initWithTitle('@work', image: current_actions_image, tag: 1)
		self
 	end

	def checkbox_selected sender
		p "clicked #{sender}"  #{button}"
		sender.setSelected true
		#checkboxSelected = !checkboxSelected;
		#checkbox setSelected:checkboxSelected];
	end

	def tableView(tableView, numberOfRowsInSection: section)
		@notes.count
	end

	def setupEvernote
		@session = EvernoteSession.sharedSession

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
		add_action_controller = AddActionViewController.alloc.init_with_tags @tags 
		self.navigationController.pushViewController(add_action_controller, animated:'YES')
	end
end