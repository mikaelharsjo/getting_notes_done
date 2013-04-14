class Note
	attr_reader :title
	attr_reader :tags

	def initialize title
		@title = title
		@tags = Array.new
	end
end