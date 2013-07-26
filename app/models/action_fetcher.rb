class ActionFetcher
	def initialize(filter)
		@filter = filter
		@note_store = EvernoteNoteStore.noteStore
	end

	def fetch(success)
		filter = create_filter
		spec = create_spec
		@note_store.findNotesMetadataWithFilter(
			filter,
			offset: 0,
			maxNotes: 10,
			resultSpec: spec,
			success: success,
			failure: nil)
	end

	private

	def create_filter
		EDAMNoteFilter.alloc.initWithOrder(
			0,
			ascending: false,
			words: nil,
			notebookGuid: @filter.notebook_guid,
			tagGuids: @filter.tag_guids,
			timeZone: nil,
			inactive: false,
			emphasized: nil)
	end

	def create_spec
		EDAMNotesMetadataResultSpec.alloc.initWithIncludeTitle(
			true,
			includeContentLength: false,
			includeCreated: false,
			includeUpdated: false,
			includeUpdateSequenceNum: false,
			includeNotebookGuid: false,
			includeTagGuids: true,
			includeAttributes: false,
			includeLargestResourceMime: false,
			includeLargestResourceSize: false)
	end
end