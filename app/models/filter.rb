class Filter # not needed?
	
	def initialize tags
		@tags = tags
		@context = Context.new
	end

	def tag_guids
		array = Array.new
		array << @tags.where_tags.select {|tag| tag.name == @context.where}[0].guid
		array << @tags.what_tags.select {|tag| tag.name == @context.what}[0].guid
		array << @tags.when_tags.select {|tag| tag.name == @context.when}[0].guid
		#if @context.what
		#	p @context.what
		#end
		#if @context.when
		#	p @context.when
		#end

		#array << @tags.where_guids.first
		p array
		array
	end
end