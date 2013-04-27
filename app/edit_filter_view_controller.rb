class EditFilterViewController < Formotion::FormController
	def init
		form = Formotion::Form.new

		form.build_section do |section|
			section.build_row do |row|
				row.title =  "What?"
				row.key =  :what
				row.type =  :picker
				row.items = ["Active projects", "Inactive projects", "Read/Review"]
			end			
		end

		form.build_section do |section|
			section.build_row do |row|
				row.title = 'When?'
				row.key =  :when
				row.type =  :picker
				row.items = ["1-Now", "2-Next", "3-Soon"]
				row.value = "1-Now"
			end
		end

		form.build_section do |section|		
			section.build_row do |row|
				row.title =  "Where?"
				row.key =  :where
				row.type =  :picker
				row.items = ["@Home", "@Work", "@Town"]
				row.value = "@Home"
			end
		end

		super.initWithForm(form)		
	end

 	def initWithNibName(name, bundle: bundle)
		super
		edit_filter_image = UIImage.imageNamed 'images/glyphicons_320_filter.png'
		self.tabBarItem = UITabBarItem.alloc.initWithTitle('Edit filter', image: edit_filter_image, tag: 1)  #initWithTabBarSystemItem(UITabBarSystemItemFavorites, tag: 1)
		#self.tabBarItem
		self
 	end
		
	def viewDidLoad
		super
		self.title = 'Edit filter'
		self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemSave, target:self, action:'submit')
	end

	def submit
		data = self.form.render
		puts data
	end
end