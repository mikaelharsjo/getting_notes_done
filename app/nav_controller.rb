class NavController < UIViewController
	include EvernoteHelpers

	#attr_reader :notes

	def viewDidLoad
		view.backgroundColor = UIColor.whiteColor
		self.title = "Next actions"
		@notes =Array.new
		@table = UITableView.alloc.initWithFrame self.view.bounds
		@table.dataSource = self
		view.addSubview @table
		#view.layer.cornerRadius = 55

		@nav_add_button = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemAdd, target:self, action:'add_action')
		self.navigationItem.rightBarButtonItem = @nav_add_button

		load_notes
	end

	def load_notes
		@session = EvernoteSession.sharedSession
		note_store = EvernoteNoteStore.noteStore
		filter = EDAMNoteFilter.alloc.initWithOrder 0, ascending:false, words:nil, notebookGuid:nil, tagGuids:nil, timeZone:nil, inactive:false, emphasized:nil
		#note_store.findNotesWithFilter filter, offset:0, maxNotes:10, success: notes_loaded, failure: output_error
 
		spec = EDAMNotesMetadataResultSpec.alloc.initWithIncludeTitle true, includeContentLength:false, includeCreated:false, includeUpdated:false, includeUpdateSequenceNum:false, includeNotebookGuid:false, includeTagGuids:false, includeAttributes:false, includeLargestResourceMime:false, includeLargestResourceSize:false
 		note_store.findNotesMetadataWithFilter filter, offset:0, maxNotes:10, resultSpec:spec, success: notes_loaded, failure: output_error
	end

	def notes_loaded
		lambda do |meta_data|
			@notes = meta_data.notes
			@table.reloadData
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

		p @notes[indexPath.row]
		#text_cell.textLabel.text = @notes[indexPath.row].title
		#text_cell.textLabel.textAlignment = UITextAlignmentRight
		checkbox_width = 25
		total_width = self.view.bounds.size.width
		label_rect = CGRectMake(90, 6, total_width - checkbox_width, 25)
		check_button_rect = CGRectMake(10, 6, checkbox_width, 25)

		label = UILabel.alloc.initWithFrame label_rect
		label.setText @notes[indexPath.row].title


		check_button = UIButton.buttonWithType UIButtonTypeRoundedRect
		check_button.setBackgroundImage UIImage.imageNamed('checkbox.png'), forState: UIControlStateNormal 
		check_button.setBackgroundImage UIImage.imageNamed('checkbox_checked.png'), forState: UIControlStateSelected
		check_button.setBackgroundImage UIImage.imageNamed('checkbox_checked.png'), forState: UIControlStateHighlighted
		check_button.adjustsImageWhenHighlighted = true
		check_button.addTarget self, action: 'checkbox_selected:', forControlEvents: UIControlEventTouchUpInside
		check_button.frame = check_button_rect
		#text_cell.contentView.addSubview check_button
		text_cell.contentView.addSubview check_button
		text_cell.contentView.addSubview label

		# put your data in the cell

		text_cell
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
		add_action_controller = AddActionViewController.alloc.init
		self.navigationController.pushViewController(add_action_controller, animated:'YES')
	end
end