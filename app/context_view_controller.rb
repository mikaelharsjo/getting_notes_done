class ContextViewController < UIViewController
	
	def viewDidLoad
		super
		view.backgroundColor = UIColor.whiteColor

		recognizer = UISwipeGestureRecognizer.alloc.initWithTarget self, action:'next'
		self.view.addGestureRecognizer recognizer
		self.title = @title

		label = UILabel.alloc.initWithFrame(CGRectMake(0, 0, self.view.bounds.size.width, 100))
		label.text = @title
		label.textAlignment = UITextAlignmentCenter
		label.backgroundColor = UIColor.clearColor
		label.shadowColor = UIColor.grayColor
		label.shadowOffset = CGSizeMake(0.0, 1.0)
		label.font = UIFont.fontWithName "Palatino-Bold", size:36.0
		self.view.addSubview label

		pickerView = UIPickerView.alloc.initWithFrame(CGRectMake(0, 110, self.view.bounds.size.width, 100))
		pickerView.delegate = self #WherePickerDelegate.new
		pickerView.showsSelectionIndicator = true
		self.view.addSubview pickerView

    	@nav_when_button = UIBarButtonItem.alloc.initWithTitle(@next, style:UIBarButtonItemStyleBordered, target:self, action:'next')
    	self.navigationItem.rightBarButtonItem = @nav_when_button
		
	end

	def next
		when_view_controller = WhenViewController.alloc.init
		self.parentViewController.pushViewController when_view_controller, animated:true
	end

	def pickerView(pickerView, didSelectRow: row, inComponent:component)
		# handle selection
	end
 
	#tell the picker how many components it will have
	def numberOfComponentsInPickerView(pickerView)
 		1
	end

	#tell the picker how many rows are available for a given component
	def pickerView(pickerView, numberOfRowsInComponent:component)
  		@tags.length
  	end
 
	#tell the picker the title for a given component
	def pickerView(pickerView, titleForRow:row, forComponent:component)
		@tags[row]
	end
 
	#tell the picker the width of each row for a given component
	def pickerView(pickerView, widthForComponent:component)
		280
	end
end 