extends ItemList

func _ready():
	var stories = Storage.list_folders_in_directory("res://examples/")
	for item in stories:
		self.add_item(item)


func on_launch_story(_idx=null):
	# The list allows selecting only one entry
	# and this should never be called if nothing is selected
	
	var story = self.get_item_text(self.get_selected_items()[0])
	Storage.set_data_directory("res://examples/" + story)
	if Storage.story_loaded:
		get_tree().change_scene_to_file("res://scenes/novel/Novel.tscn")
	# TODO else error
