class NullTag
	attr_reader :guid
end

class Tags
	include EvernoteHelpers

	def initialize
		p 'initialize'
		@session = EvernoteSession.sharedSession
		@note_store = EvernoteNoteStore.noteStore
		@note_store.listTagsWithSuccess tags_loaded, failure: output_error
	end

	def tags_loaded
		lambda do |tags|
			where_tag = tags.select {|t| t.name == 'Where'}[0] || NullTag.new
			when_tag = tags.select {|t| t.name == 'When'}[0] || NullTag.new
			what_tag = tags.select {|t| t.name == 'What'}[0] || NullTag.new
			who_tag = tags.select {|t| t.name == 'Who'}[0] || NullTag.new
			
			@where_tags = tags.select {|t| t.parentGuid == where_tag.guid }
			@when_tags = tags.select {|t| t.parentGuid == when_tag.guid }
			@what_tags = tags.select {|t| t.parentGuid == what_tag.guid }
			@who_tags = tags.select {|t| t.parentGuid == who_tag.guid }

			@when_tags.each do |tag|
				p tag
			end
		end
	end

	def when
		['!-Daily', '1-Now', '2-Next', '3-Soon']
		#p @when_tags.length
		#@when_tags.map {|tag| tag.name}
	end

	def what 
		["Active projects", "Inactive projects", "Read/Review"]
	end

	def where
		["@Home", "@Work", "@Town"]
	end

	def who
		["Leo", "Johanna", "Noah", "Vera"]
	end
end