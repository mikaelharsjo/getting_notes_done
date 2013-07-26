module EvernoteHelpers
	def output_error
		->(error) { puts "#{error.domain} #{error.code}" }
	end
end