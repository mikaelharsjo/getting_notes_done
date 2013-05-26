class NullTag
	attr_reader :guid
end

class Tags
	include EvernoteHelpers

	attr_accessor :where_tags, :when_tags, :what_tags, :who_tags

	def initialize
		#note_store.listTagsWithSuccess tags_loaded, failure: output_error
	end

	def self.fetch &block
		session = EvernoteSession.sharedSession
		note_store = EvernoteNoteStore.noteStore
		note_store.listTagsWithSuccess(lambda do |tags|
			where_root_tag = tags.select {|t| t.name == 'Where'}[0] || NullTag.new
			when_root_tag = tags.select {|t| t.name == 'When'}[0] || NullTag.new
			what_root_tag = tags.select {|t| t.name == 'What'}[0] || NullTag.new
			who_root_tag = tags.select {|t| t.name == 'Who'}[0] || NullTag.new
			
			@where_tags = tags_with_parent tags, where_root_tag
			@when_tags = tags_with_parent tags, when_root_tag
			@what_tags = tags_with_parent tags, what_root_tag
			@who_tags = tags_with_parent tags, who_root_tag

			block.call(@where_tags)
		end, failure: output_error)
	end

	def self.output_error
	end

	def self.tags_loaded
		lambda do |tags|
			where_root_tag = tags.select {|t| t.name == 'Where'}[0] || NullTag.new
			when_root_tag = tags.select {|t| t.name == 'When'}[0] || NullTag.new
			what_root_tag = tags.select {|t| t.name == 'What'}[0] || NullTag.new
			who_root_tag = tags.select {|t| t.name == 'Who'}[0] || NullTag.new
			
			@where_tags = tags_with_parent tags, where_root_tag
			@when_tags = tags_with_parent tags, when_root_tag
			@what_tags = tags_with_parent tags, what_root_tag
			@who_tags = tags_with_parent tags, who_root_tag

			block.call(@where_tags)

			#@where =  
			#@when = tags_to_names when_tags
			#@what = tags_to_names what_tags
			#@who = tags_to_names who_tags
		end
	end

	def where
		tags_to_names @where_tags
	end

	def where_guids
		tags_to_guids @where_tags
	end	

	def when
		tags_to_names @when_tags
	end

	def when_guids
		tags_to_guids @when_tags
	end

	def what
		tags_to_names @what_tags
	end

	def what_guids
		tags_to_guids @what_tags
	end

	def who
		tags_to_names @who_tags
	end

	def who_guids
		tags_to_guids @who_tags
	end

	def self.tags_with_parent tags, parent
		tags.select {|t| t.parentGuid == parent.guid }
	end

	def self.tags_to_names tags
		tags.map {|tag| tag.name}
	end	

	def tags_to_guids tags
		tags.map {|tag| tag.guid}
	end
end