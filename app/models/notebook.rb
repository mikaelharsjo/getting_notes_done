class Notebook
	def initialize
		@note_store = EvernoteNoteStore.noteStore
	end

	def self.fetch(name, &block)
		@name = name
 		@block = block
		note_store = EvernoteNoteStore.noteStore
		note_store.listNotebooksWithSuccess fetched_all_notebooks, failure: nil
	end

	def self.fetched_all_notebooks
		lambda do |notebooks|
			completed_notebook = notebooks.find { |notebook| notebook.name.downcase == @name }
			@block.call(completed_notebook) if completed_notebook
		end
	end
end