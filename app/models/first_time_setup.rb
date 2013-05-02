class FirstTimeSetup
	include EvernoteHelpers
	
	def initialize note_store
		@note_store = note_store
	end

	def run
		create_notebook_with_name 'Action pending'
		create_notebook_with_name 'Completed'

		create_parent_tag_with_name 'Where', create_where_children_tags
		create_parent_tag_with_name 'When', create_when_children_tags
		create_parent_tag_with_name 'What', create_what_children_tags
		create_parent_tag_with_name 'Who', lambda { nil }
	end

	private

	def create_notebook_with_name name
		puts 'create_notebook_with_name'
		notebook = EDAMNotebook.alloc.init
		notebook.name = name
		@note_store.createNotebook notebook, success: lambda {|notebook| puts notebook.name}, failure: output_error
	end

	def create_parent_tag_with_name name, success
		puts 'create_parent_tag_with_name'
		where_tag = EDAMTag.alloc.init
		where_tag.name = name
		@note_store.createTag where_tag, success: success, failure: output_error
	end

	def create_where_children_tags
		puts 'create_where_children_tags'
		lambda do |parent_tag|
			create_child_tag_with_name '@home', parent_tag
			create_child_tag_with_name '@town', parent_tag
			create_child_tag_with_name '@work', parent_tag
		end
	end

	def create_when_children_tags
		puts 'create_when_children_tags'
		lambda do |parent_tag|
			create_child_tag_with_name '!Daily', parent_tag
			create_child_tag_with_name '1-Now', parent_tag
			create_child_tag_with_name '2-Next', parent_tag
			create_child_tag_with_name '3-Soon', parent_tag
			create_child_tag_with_name '4-Later', parent_tag
			create_child_tag_with_name '5-Someday', parent_tag
		end
	end

	def create_what_children_tags
		puts 'create_what_children_tags'
		lambda do |parent_tag|
			create_child_tag_with_name 'Active projects', parent_tag
			create_child_tag_with_name 'Inactive projects', parent_tag
			create_child_tag_with_name '@work', parent_tag
		end
	end

	def create_child_tag_with_name name, parent_tag
		puts 'create_child_tag_with_name'
		tag = EDAMTag.alloc.init
		tag.name = name
		tag.parentGuid = parent_tag.guid
		@note_store.createTag tag, success: lambda {|tag| puts tag}, failure: output_error 	 
	end
end