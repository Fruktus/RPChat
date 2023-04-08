extends FileDialog



func _on_dir_selected(dir):
	Storage.set_data_directory(dir)
	if Storage.story_loaded:
		get_tree().change_scene_to_file("res://scenes/novel/Novel.tscn")
