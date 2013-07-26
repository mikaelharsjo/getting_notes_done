class Note
	attr_reader :title, :guid, :when

	def initialize(title, guid, when_tag)
		@title = title
		@guid = guid
		@when = when_tag.nil? ? NullTag.new : when_tag
	end
end