class Filter # not needed?
	
	def initialize tags
		@tags = tags
		@context = Context.new
	end

	def tag_guids
		array = Array.new
		array << @tags.where_guids_with_name(@context.where)
		array << @tags.what_guids_with_name(@context.what)
		array << @tags.when_guids_with_name(@context.when)

		array.compact
	end
end