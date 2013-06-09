class Notebook
	def initialize
		session = EvernoteSession.sharedSession
		@note_store = EvernoteNoteStore.noteStore
	end

	def self.fetch name, &block
		@name = name
 		@block = block
		note_store = EvernoteNoteStore.noteStore
		note_store.listNotebooksWithSuccess fetched_all_notebooks, failure: output_error
	end

	def self.fetched_all_notebooks
		lambda do |notebooks|
			notebooks.each{|notebook| p(notebook.name)}
			completed_notebook = notebooks.detect{|notebook| notebook.name.downcase == 'completed'}
			if completed_notebook
				@block.call(completed_notebook)
			end
		end	
	end

	def self.output_error
	end
end