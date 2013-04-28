module EvernoteHelpers
	def output_error
		lambda {|error| puts "#{error.domain} #{error.code}" }
	end
end