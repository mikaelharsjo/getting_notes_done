class NullTag
	attr_reader :guid
	#attr_rea
end

class Tags
	include EvernoteHelpers

	attr_accessor :where, :when, :what, :who

	def initialize
		session = EvernoteSession.sharedSession
		note_store = EvernoteNoteStore.noteStore
		note_store.listTagsWithSuccess tags_loaded, failure: output_error
	end

	def tags_loaded
		lambda do |tags|
			where_root_tag = tags.select {|t| t.name == 'Where'}[0] || NullTag.new
			when_root_tag = tags.select {|t| t.name == 'When'}[0] || NullTag.new
			what_root_tag = tags.select {|t| t.name == 'What'}[0] || NullTag.new
			who_root_tag = tags.select {|t| t.name == 'Who'}[0] || NullTag.new
			
			where_tags = tags_with_parent tags, where_root_tag
			when_tags = tags_with_parent tags, when_root_tag
			what_tags = tags_with_parent tags, what_root_tag
			who_tags = tags_with_parent tags, who_root_tag

			@where = tags_to_names where_tags 
			@when = tags_to_names when_tags
			@what = tags_to_names what_tags
			@who = tags_to_names who_tags
		end
	end

	def tags_with_parent tags, parent
		tags.select {|t| t.parentGuid == parent.guid }
	end

	def tags_to_names tags
		tags.map {|tag| tag.name}
	end	
end