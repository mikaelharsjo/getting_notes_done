class Filter # not needed?
	
	def initialize tags
		@tags = tags
	end

	def tag_guids
		p @tags.where_guids[0]
		array = Array.new
		array << @tags.where_guids.first
	end
end