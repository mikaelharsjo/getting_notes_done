class ActionFetcher
	include EvernoteHelpers

	def initialize filter
		@filter = filter
		session = EvernoteSession.sharedSession
		@note_store = EvernoteNoteStore.noteStore		
	end

	def fetch success
		filter = EDAMNoteFilter.alloc.initWithOrder 0, ascending:false, words:nil, notebookGuid: @filter.completed_notebook_guid, tagGuids: @filter.tag_guids, timeZone:nil, inactive:false, emphasized:nil
		spec = EDAMNotesMetadataResultSpec.alloc.initWithIncludeTitle true, includeContentLength:false, includeCreated:false, includeUpdated:false, includeUpdateSequenceNum:false, includeNotebookGuid:false, includeTagGuids:true, includeAttributes:false, includeLargestResourceMime:false, includeLargestResourceSize:false
		@note_store.findNotesMetadataWithFilter filter, offset:0, maxNotes:10, resultSpec: spec, success: success, failure: output_error		
	end
end