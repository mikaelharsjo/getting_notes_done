class AppDelegate 	
	EVERNOTE_HOST = BootstrapServerBaseURLStringSandbox
	CONSUMER_KEY = 'mikaelharsjo-3345' #"mikaelharsjo"
	CONSUMER_SECRET = 'd3c1fe39624814f0' #"b9675bc5102a6a86"
	
	def application(application, didFinishLaunchingWithOptions:launchOptions)
		EvernoteSession.setSharedSessionHost(EVERNOTE_HOST, consumerKey:CONSUMER_KEY, consumerSecret:CONSUMER_SECRET)
		@session = EvernoteSession.sharedSession
    	@window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    	@window.makeKeyAndVisible
		
		unless @session.isAuthenticated
			@window.rootViewController = AuthenticationViewController.alloc.initWithNibName(nil, bundle: nil)
		else
			nav_controller = NavController.alloc.init
			@window.rootViewController = UINavigationController.alloc.initWithRootViewController nav_controller
		end
		true
  	end

 
end
