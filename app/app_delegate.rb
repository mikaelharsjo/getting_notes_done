class AppDelegate 	
	EVERNOTE_HOST = BootstrapServerBaseURLStringSandbox
	CONSUMER_KEY = 'mikaelharsjo-3345' #"mikaelharsjo"
	CONSUMER_SECRET = 'd3c1fe39624814f0' #"b9675bc5102a6a86"
	
	def application(application, didFinishLaunchingWithOptions:launchOptions)
		EvernoteSession.setSharedSessionHost(EVERNOTE_HOST, consumerKey:CONSUMER_KEY, consumerSecret:CONSUMER_SECRET)
		@session = EvernoteSession.sharedSession
		@window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
		next_actions_controller_without_tags = NextActionsController.alloc.init
		#next_actions_controller_without_tags_2 = NextActionsController.alloc.init
   		@window.rootViewController = next_actions_controller_without_tags
		@window.makeKeyAndVisible

		global_styles

		auth_controller = AuthenticationViewController.alloc.initWithNibName(nil, bundle: nil)
		auth_nav_controller = UINavigationController.alloc.initWithRootViewController auth_controller
		#next_actions_nav_controller_without_tags = UINavigationController.alloc.initWithRootViewController next_actions_controller_without_tags_2
		@tab_controller = UITabBarController.alloc.initWithNibName(nil, bundle: nil)

		unless @session.isAuthenticated
			@window.rootViewController = auth_nav_controller
		else
			load_default_controllers
		end

	    # show splash Screen
		image = (568 == UIScreen.mainScreen.bounds.size.height) ? ("Default-568h") : ("Default")
		image_view = UIImageView.alloc.initWithImage(UIImage.imageNamed(image))
		@window.rootViewController.view.addSubview(image_view)
		@window.rootViewController.view.bringSubviewToFront(image_view)

		# fade out splash image
		fade_out_timer = 1.0
		UIView.transitionWithView(@window, duration:fade_out_timer, options:UIViewAnimationOptionTransitionNone, animations: lambda {image_view.alpha = 0}, completion: lambda do |finished|
		  image_view.removeFromSuperview
		  image_view = nil
		  UIApplication.sharedApplication.setStatusBarHidden(false, animated:false)
		end) 
		
		true
	end

	def load_default_controllers
		Notebook.fetch 'action pending' do |notebook|
			@notebook_guid = notebook.guid
			Tags.fetch do |tags|
				next_actions_controller = NextActionsController.alloc.init_with_tags_and_notebook_guid tags, @notebook_guid					
				edit_filter_controller = EditFilterViewController.alloc.init_with_tags tags

				next_actions_nav_controller = UINavigationController.alloc.initWithRootViewController next_actions_controller
				edit_filter_nav_controller = UINavigationController.alloc.initWithRootViewController edit_filter_controller
				
				@tab_controller.viewControllers = [next_actions_nav_controller, edit_filter_nav_controller]
				@window.rootViewController = @tab_controller
			end
		end
	end

	def global_styles
		UINavigationBar.appearance.setBackgroundImage UIImage.imageNamed('images/menu-bar.png'), forBarMetrics: UIBarMetricsDefault
		back_button_image = UIImage.imageNamed 'images/back.png'
		UIBarButtonItem.appearance.setBackButtonBackgroundImage back_button_image, forState:UIControlStateNormal, barMetrics:UIBarMetricsDefault

		bar_button_image = UIImage.imageNamed 'images/menubar-brn.png'
		UIBarButtonItem.appearance.setBackgroundImage bar_button_image, forState:UIControlStateNormal, barMetrics:UIBarMetricsDefault  		
	
		UITabBar.appearance.setBackgroundImage UIImage.imageNamed('images/tabbar.png')
	end

 
end
