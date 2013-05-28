class AuthenticationViewController < UIViewController
	def viewDidLoad
		super
		self.title = "Sign in"		
	end

	def viewDidAppear animated
		launchEvernoteAuth
	end

 	def launchEvernoteAuth
		@session = EvernoteSession.sharedSession
		puts "Session host: #{@session.host}"
		puts "Session key: #{@session.consumerKey}"
		puts "Session secret: #{@session.consumerSecret}"

		#@window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    	#@window.makeKeyAndVisible
    	@session.logout
		@session.authenticateWithViewController(self, #completionHandler: auth_completed)
			completionHandler: lambda do |error|
				if error or not @session.isAuthenticated
					puts 'error'
					#NSLog error.code
				else
					puts 'Were authenticated!'				
					userStore = EvernoteUserStore.userStore
					userStore.getUserWithSuccess lambda {|user| puts user.username}, failure: lambda {|error| puts "#{error.domain} #{error.code}"}	
					self.tabBarController.selectedIndex = 1
				end	
			end)	
	end

 	def initWithNibName(name, bundle: bundle)
		super
		self.tabBarItem = UITabBarItem.alloc.initWithTitle('@work', image: nil, tag: 1)  #initWithTabBarSystemItem(UITabBarSystemItemFavorites, tag: 1)
		#self.tabBarItem
		self
 	end
end