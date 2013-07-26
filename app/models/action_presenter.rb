class ActionPresenter
	def present_and_sort(tags, &block)
		lambda do |meta_data|
			actions = Array.new
			# remove nils
			meta_data.notes.map { |note| note.tagGuids = note.tagGuids.to_a }

			meta_data.notes.each do |note|
				when_tags = []
				note.tagGuids.each do |tag_guid|
					when_tags = tags.when_tags.select { |when_tag| when_tag.guid == tag_guid }
				end

				actions << Note.new(note.title, note.guid, when_tags.first)
			end

			actions.sort! { |a, b| a.when.name <=> b.when.name }

			block.call(actions)
		end
	end
end