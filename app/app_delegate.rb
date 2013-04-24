class AppDelegate 	
	EVERNOTE_HOST = BootstrapServerBaseURLStringSandbox
	CONSUMER_KEY = 'mikaelharsjo-3345' #"mikaelharsjo"
	CONSUMER_SECRET = 'd3c1fe39624814f0' #"b9675bc5102a6a86"
	
	def application(application, didFinishLaunchingWithOptions:launchOptions)
		EvernoteSession.setSharedSessionHost(EVERNOTE_HOST, consumerKey:CONSUMER_KEY, consumerSecret:CONSUMER_SECRET)
		@session = EvernoteSession.sharedSession
    	@window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    	@window.makeKeyAndVisible
		
		global_styles

		unless @session.isAuthenticated
			@window.rootViewController = AuthenticationViewController.alloc.initWithNibName(nil, bundle: nil)
		else
			controller = NextActionsController.alloc.initWithNibName nil, bundle: nil
			next_actions_controller = UINavigationController.alloc.initWithRootViewController controller
			auth_controller = AuthenticationViewController.alloc.initWithNibName(nil, bundle: nil)

			tab_controller = UITabBarController.alloc.initWithNibName(nil, bundle: nil)
  			tab_controller.viewControllers = [next_actions_controller, auth_controller]
  			@window.rootViewController = tab_controller
		end
		true
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
