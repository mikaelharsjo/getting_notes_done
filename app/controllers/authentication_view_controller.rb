class AuthenticationViewController < UIViewController
	def viewDidAppear animated
		authenticate
	end

 	def authenticate
		@session = EvernoteSession.sharedSession
		puts "Session host: #{@session.host}"
		puts "Session key: #{@session.consumerKey}"
		puts "Session secret: #{@session.consumerSecret}"

    	@session.logout
		@session.authenticateWithViewController(self,
			completionHandler: lambda do |error|
				if error or not @session.isAuthenticated
					puts 'error'
				else
					puts 'Were authenticated!'				
					userStore = EvernoteUserStore.userStore
					userStore.getUserWithSuccess lambda {|user| puts user.username}, failure: lambda {|error| puts "#{error.domain} #{error.code}"}	
					self.navigationController.pushViewController(NextActionsController.alloc.init, animated:true)
				end	
			end)	
	end

 	def initWithNibName(name, bundle: bundle)
		super
		self.tabBarItem = UITabBarItem.alloc.initWithTitle('Sign in', image: nil, tag: 1)
		self
 	end
end