module InitWithTags
	attr_reader :tags
	def init_with_tags tags
		@tags = tags
		init
	end
end