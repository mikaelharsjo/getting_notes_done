class Notebook
	def initialize
		session = EvernoteSession.sharedSession
		@note_store = EvernoteNoteStore.noteStore
	end

	def self.fetch name, &block
		@name = name
 		@block = block
		note_store = EvernoteNoteStore.noteStore
		note_store.listNotebooksWithSuccess fetched_all_notebooks, failure: nil
	end

	def self.fetched_all_notebooks
		p @name
		lambda do |notebooks|
			completed_notebook = notebooks.detect{|notebook| notebook.name.downcase == @name}
			p completed_notebook
			p completed_notebook.name
			if completed_notebook
				@block.call(completed_notebook)
			end
		end	
	end
end