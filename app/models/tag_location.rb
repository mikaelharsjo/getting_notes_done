# This class is a indication that a physical location is
# connected to a (where) tag
class TagLocation
	include MotionModel::Model
	include MotionModel::ArrayModelAdapter

	columns tag_name: :string,
		tag_guid: :string,
		latitude: :float,
		longitude: :float
end