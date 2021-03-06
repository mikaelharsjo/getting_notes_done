class Filter
	attr_reader :notebook_guid

	def initialize(tags, notebook_guid)
		@tags = tags
		@notebook_guid = notebook_guid
		@context = Context.new
	end

	def tag_guids
		array = []
		array << @tags.where_guids_with_name(@context.where)
		array << @tags.what_guids_with_name(@context.what)

		array.compact
	end
end