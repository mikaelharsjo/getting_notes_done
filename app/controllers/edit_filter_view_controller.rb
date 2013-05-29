class EditFilterViewController < Formotion::FormController
	include InitWithTags

	def init
		@context = Context.new
		add_tab_bar_item
		form = build_form
		super.initWithForm(form)	
	end

 	def add_tab_bar_item
		edit_filter_image = UIImage.imageNamed 'images/glyphicons_320_filter.png'
		self.tabBarItem = UITabBarItem.alloc.initWithTitle('Edit filter', image: edit_filter_image, tag: 1)
 	end

	def viewDidLoad
		super
		self.title = 'Custom filter'
		self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemDone, target:self, action:'submit')
	end

 	def build_form
 		form = Formotion::Form.new

		form.build_section do |section|
			section.build_row do |row|
				row.title =  "What?"
				row.key =  :what
				row.type =  :picker
				row.items = @tags.what
			end			
		end

		form.build_section do |section|
			section.build_row do |row|
				row.title = 'When?'
				row.key =  :when
				row.type =  :picker
				row.items = @tags.when
				# set from context.when
				#row.value = @tags.when.first
			end
		end

		form.build_section do |section|		
			section.build_row do |row|
				row.title =  "Where?"
				row.key =  :where
				row.type =  :picker
				row.items = @tags.where
				#row.value = @tags.where.first
			end
		end

		form
 	end

	def submit
		p 'submit'
		data = self.form.render
		@context.where = data[:where]
		p @context.where
		@context.what = data[:what]
		@context.when = data[:when]
		@context.save

		self.tabBarController.selectedIndex = 0
	end
end