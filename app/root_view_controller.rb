class RootViewController < UIViewController
	def viewDidLoad
		super

		@box = UIView.alloc.initWithFrame CGRectMake(0, 0, 100, 100)
		@box.backgroundColor = UIColor.blueColor
		self.view.addSubview(@box)
		# UIButtonTypeRoundedRect is the standard button style on iOS
		@button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
		# A button has multiple "control states", like disabled, highlighted, and normal
		@button.setTitle("Change Color", forState:UIControlStateNormal)
		# Sizes the button to fit its title
		@button.sizeToFit
		# Position the button below our box.
		@button.frame = CGRectMake(0, @box.frame.size.height + 20, @button.frame.size.width, @button.frame.size.height)
		@button.addTarget(self, 
			action: :goto_where,
			forControlEvents: UIControlEventTouchUpInside)
		self.view.addSubview(@button)	
	end

	  # The touch callback for the button
	  def goto_where
	  	where_controller = WhereViewController.alloc.init
	  	self.parentViewController.pushViewController where_controller, animated:true
	  end
end