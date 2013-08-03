describe 'TagLocation Model' do
	before do
    	@tag_location = TagLocation.create tag_name: '@home',
			tag_guid: '21EC2020-3AEA-1069-A2DD-08002B30309D',
			latitude: 57.706222,
			longitude: 11.976471
	end

	it 'exists' do
		Object.const_defined?('TagLocation').should.be.true
	end

	it 'has	a tag_name, a tag_guid, a latitude and a longitude' do
		@tag_location.should.respond_to :tag_name
	end

	it 'can be persisted' do
		@persisted_tag_location = TagLocation.create tag_name: '@home',
			tag_guid: '21EC2020-3AEA-1069-A2DD-08002B30309D',
			latitude: 57.706222,
			longitude: 11.976471
		1.should == 1

		tag_location = TagLocation.where(:tag_name).eq('@home')
		tag_location.first.tag_name.should == @persisted_tag_location.tag_name
	end
end