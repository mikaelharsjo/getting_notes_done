class WherePickerDelegate
	def initialize
		@tags = ['Home', 'Work', 'Away']
	end

	def pickerView(pickerView, didSelectRow: row, inComponent:component)
		# handle selection
	end
 
	#tell the picker how many components it will have
	def numberOfComponentsInPickerView(pickerView)
 		1
	end

	#tell the picker how many rows are available for a given component
	def pickerView(pickerView, numberOfRowsInComponent:component)
  		@tags.length
  	end
 
	#tell the picker the title for a given component
	def pickerView(pickerView, titleForRow:row, forComponent:component)
		@tags[row]
	end
 
	#tell the picker the width of each row for a given component
	def pickerView(pickerView, widthForComponent:component)
		280
	end
end