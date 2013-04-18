class AppDelegate 	
	EVERNOTE_HOST = BootstrapServerBaseURLStringSandbox
	CONSUMER_KEY = 'mikaelharsjo-3345' #"mikaelharsjo"
	CONSUMER_SECRET = 'd3c1fe39624814f0' #"b9675bc5102a6a86"
	
	def application(application, didFinishLaunchingWithOptions:launchOptions)
		EvernoteSession.setSharedSessionHost(EVERNOTE_HOST, consumerKey:CONSUMER_KEY, consumerSecret:CONSUMER_SECRET)
		@session = EvernoteSession.sharedSession
    	@window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    	@window.makeKeyAndVisible
		
		add_global_styles
		
		unless @session.isAuthenticated
			@window.rootViewController = AuthenticationViewController.alloc.initWithNibName(nil, bundle: nil)
		else
			nav_controller = NavController.alloc.init

			
			@window.rootViewController = UINavigationController.alloc.initWithRootViewController nav_controller
		end
		true
  	end

  	def add_global_styles
		UINavigationBar.appearance.setBackgroundImage UIImage.imageNamed('images/menu-bar.png'), forBarMetrics: UIBarMetricsDefault
		#UINavigationBar.appearance.setTitleTextAttributes = ({
		#	UITextAttributeFont => UIFont.fontWithName('fonts/Inconsolata', size:24),
		#	UITextAttributeTextShadowColor => UIColor.grayColor,   #WithGray(0.0, alpha:0.4),
		#	UITextAttributeTextColor => UIColor.whiteColor
		#})
		back_button_image = UIImage.imageNamed 'images/back.png' #.resizableImageWithCapInsets UIEdgeInsetsMake(0, 13, 0, 6)
		UIBarButtonItem.appearance.setBackButtonBackgroundImage back_button_image, forState:UIControlStateNormal, barMetrics:UIBarMetricsDefault

		bar_button_image = UIImage.imageNamed 'images/menubar-brn.png'
		UIBarButtonItem.appearance.setBackgroundImage bar_button_image, forState:UIControlStateNormal, barMetrics:UIBarMetricsDefault  		
	end

 
end
