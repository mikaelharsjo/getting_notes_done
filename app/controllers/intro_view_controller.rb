class IntroViewController < UIViewController
	CONTENT = 'Thanks for giving us a try! To start storing your next actions in the cloud, sign in to your Evernote account.

When you sign in we will prepare your account by adding two notebooks and a few tags.'
	def viewDidLoad
		title_font = UIFont.fontWithName("Delius-Regular", size:22)
		self.view.backgroundColor = UIColor.colorWithPatternImage(UIImage.imageNamed('images/notes_table_bg.png'))
  		title = UILabel.new
		title.font = title_font
		title.text = "Welcome to Next Actions!"
		title.frame = [[60, 10], [320, 30]]
		title.backgroundColor = UIColor.clearColor

		content_font = UIFont.fontWithName("Inconsolata", size:16)
		content = UILabel.new
		content.font = content_font
		content.text = CONTENT
		content.frame = [[60, 70], [250, 300]]
		content.backgroundColor = UIColor.clearColor
		content.numberOfLines = 0
		content.sizeToFit
		content.lineBreakMode = NSLineBreakByWordWrapping

		button = UIButton.buttonWithType UIButtonTypeCustom
		button.setBackgroundImage UIImage.imageNamed('images/blue-button.png'), forState: UIControlStateNormal
		button.setTitle "Ok, let´s go!", forState: UIControlStateNormal
		button.frame = [[100, 280], [150, 50]]

		button.when(UIControlEventTouchUpInside) do
  			self.navigationController.pushViewController(AuthenticationViewController.alloc.init, animated:true)
		end

		self.view.addSubview title
		self.view.addSubview content
		self.view.addSubview button
	end
end