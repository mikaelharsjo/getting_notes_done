class AddActionViewController < Formotion::FormController
	include EvernoteHelpers
	include InitWithTags

	def init
		super.initWithForm(build_form)	
	end
		
	def viewDidLoad
		super

		self.title = 'Add action'
		self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemSave, target:self, action:'submit')
	end

	def build_form
 		form = Formotion::Form.new

		form.build_section do |section|
			section.build_row do |row|
				row.title = "Title"
				row.key = :title
				row.type = :string
			end
		end

		form.build_section do |section|
			section.build_row do |row|
				row.title =  "What?"
				row.key =  :what
				row.type =  :picker
				row.items = @tags.what
			end			
		end

		form.build_section do |section|
			section.build_row do |row|
				row.title = 'When?'
				row.key =  :when
				row.type =  :picker
				row.items = @tags.when
				row.value = @tags.when.first
			end
		end

		form.build_section do |section|		
			section.build_row do |row|
				row.title =  "Where?"
				row.key =  :where
				row.type =  :picker
				row.items = @tags.where
				# set from context?
				row.value = @tags.where.first
			end
		end

		form.build_section do |section|
			section.build_row do |row|
				row.title =  "Who?"
				row.key =  :who
				row.type =  :picker
				row.items = @tags.who
			end
		end

		form
	end

	def submit
		data = self.form.render

		note = EDAMNote.alloc.init
		note.title = data[:title]
		note.content = '<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd"><en-note></en-note>'

		if data[:where] or data[:when] or data[:who] or data[:what]
			note.tagNames = Array.new
			note.tagNames << data[:where] if data[:where] 
			note.tagNames << data[:when] if data[:when]
			note.tagNames << data[:who] if data[:who]
			note.tagNames << data[:what] if data[:what]
		end

		note_store = EvernoteNoteStore.noteStore
		note_store.createNote note, success: redirect_after_save, failure: output_error
	end

	def redirect_after_save
		lambda do |note| 
			self.navigationController.popToRootViewControllerAnimated true
		end
	end
end