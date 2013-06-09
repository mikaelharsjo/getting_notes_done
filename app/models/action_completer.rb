class ActionCompleter
	include EvernoteHelpers

	def initialize
		session = EvernoteSession.sharedSession
		@note_store = EvernoteNoteStore.noteStore
	end

	def complete_with_guid note_guid
		@note_store.getNoteWithGuid note_guid, withContent: false, withResourcesData: false, withResourcesRecognition: false, withResourcesAlternateData: false, success: fetched_complete_note, failure: output_error
	end

	def fetched_complete_note
		lambda do |complete_note|
			@complete_note = complete_note
			Notebook.fetch 'completed' { |notebook| move_to notebook }
		end
	end

	def move_to notebook	
		@complete_note.notebookGuid = notebook.guid
		@note_store.updateNote @complete_note, success: note_updated, failure: output_error			
	end

	def note_updated
		lambda do |note|
			p note
		end	
	end
end