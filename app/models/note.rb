class Note
	attr_reader :title
	attr_reader :guid
	attr_reader :tags

	def initialize title, guid
		@title = title
		@guid = guid
		@tags = Array.new
	end
end