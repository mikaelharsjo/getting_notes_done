class NextActionsController < UITableViewController
	CHECKBOX_WIDTH = 25

	include EvernoteHelpers
	include InitWithTags

	def init_with_tags_and_notebook_guid tags, notebook_guid
		@notebook_guid = notebook_guid
		@action_completer = ActionCompleter.new
		init_with_tags tags
		initWithNibName nil, bundle: nil
	end

 	def initWithNibName(name, bundle: bundle)
		super
		current_actions_image = UIImage.imageNamed 'images/glyphicons_193_circle_ok.png'
		change_context_image = UIImage.imageNamed 'images/glyphicons_370_globe_af.png'
		self.tabBarItem = UITabBarItem.alloc.initWithTitle('@work', image: current_actions_image, tag: 1)
		self
 	end

	def viewDidLoad
		view.backgroundColor = UIColor.whiteColor
		self.title = "Next actions"
		@actions = Array.new

		image_view = UIImageView.alloc.initWithImage(UIImage.imageNamed('images/notes_table_bg.png'))
		self.tableView.backgroundView = image_view

		self.refreshControl = UIRefreshControl.alloc.init
		self.refreshControl.addTarget self, action: 'fetch_actions_from_evernote', forControlEvents: UIControlEventValueChanged

		nav_add_button = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemAdd, target: self, action: 'add_action')
		self.navigationItem.rightBarButtonItem = nav_add_button		
	end

	def viewDidAppear(animated)		
		fetch_actions_from_evernote
	end

	def fetch_actions_from_evernote
		filter = Filter.new @tags, @completed_notebook_guid
		self.refreshControl.beginRefreshing

		action_fetcher = ActionFetcher.new filter
		action_fetcher.fetch notes_loaded
	end

	def notes_loaded
		@actions.clear
		lambda do |meta_data|
			meta_data.notes.each do |note| 
				@actions << Note.new(note.title, note.guid)
			end

			self.refreshControl.endRefreshing
			self.tableView.reloadData
		end
	end

	def label_rect
		total_width = self.view.bounds.size.width
		CGRectMake(60, 10, total_width - CHECKBOX_WIDTH, CHECKBOX_WIDTH)
	end

	def check_button_rect
		check_button_rect = CGRectMake(10, 6, CHECKBOX_WIDTH, CHECKBOX_WIDTH)
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

		text_cell.contentView.addSubview create_check_button indexPath
		text_cell.contentView.addSubview create_label indexPath

		text_cell
	end

	def create_check_button indexPath
		check_button = UIButton.buttonWithType UIButtonTypeRoundedRect
		check_button.backgroundColor = UIColor.clearColor
		checked_image = UIImage.imageNamed('images/black_checkbox_checked.png')
		check_button.setBackgroundImage UIImage.imageNamed('images/black_checkbox.png'), forState: UIControlStateNormal
		check_button.setBackgroundImage checked_image, forState: UIControlStateSelected
		check_button.setBackgroundImage checked_image, forState: UIControlStateHighlighted
		check_button.adjustsImageWhenHighlighted = true
		check_button.addTarget self, action: 'checkbox_selected:', forControlEvents: UIControlEventTouchUpInside
		check_button.frame = check_button_rect
		check_button.tag = indexPath.row #@actions[indexPath.row].guid
		check_button
	end

	def create_label indexPath
		label = UILabel.alloc.initWithFrame label_rect
		label.font = UIFont.fontWithName('Inconsolata', size: 19)
		label.text = "#{indexPath.row + 1}. #{@actions[indexPath.row].title}"
		label.backgroundColor = UIColor.clearColor
		label
	end

	def checkbox_selected sender
		sender.setSelected true
		note = @actions[sender.tag]
		@action_completer.complete_with_guid note.guid
	end

	def tableView(tableView, numberOfRowsInSection: section)
		@actions.count
	end

	def add_action				
		add_action_controller = AddActionViewController.alloc.init_with_tags_and_notebook_guid @tags, @notebook_guid
		self.navigationController.pushViewController(add_action_controller, animated:'YES')
	end
end