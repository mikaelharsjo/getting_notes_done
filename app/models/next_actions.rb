class NextActionsFetcher
	def self.fetch filter, &block
		#self.refreshControl.beginRefreshing
		@session = EvernoteSession.sharedSession
		@note_store = EvernoteNoteStore.noteStore
		filter = EDAMNoteFilter.alloc.initWithOrder 0, ascending:false, words:nil, notebookGuid:nil, tagGuids: filter.tag_guids, timeZone:nil, inactive:false, emphasized:nil

		spec = EDAMNotesMetadataResultSpec.alloc.initWithIncludeTitle true, includeContentLength:false, includeCreated:false, includeUpdated:false, includeUpdateSequenceNum:false, includeNotebookGuid:false, includeTagGuids:true, includeAttributes:false, includeLargestResourceMime:false, includeLargestResourceSize:false
		@note_store.findNotesMetadataWithFilter filter, offset:0, maxNotes:10, resultSpec:spec, success: notes_loaded, failure: output_error

		block.call
	end

	def self.notes_loaded &block
		@notes.clear
		lambda do |meta_data|
			meta_data.notes.each do |note| 
				@notes << Note.new(note.title)
			end

			#self.refreshControl.endRefreshing
			#self.tableView.reloadData
		end
	end
end
