extends ResourcePreloader

var data_directory: String = ''
var story: String = ''
var loaded_resources = []
# TODO Add support for stories in PCK format
# https://docs.godotengine.org/en/stable/tutorials/export/exporting_pcks.html

# TODO make the main menu set the content of the storage and switch scene,
# The scene loads and checks if the storage was loaded, if so use it,
# else run demo story


func _ready():
	set_process(false)


func set_data_directory(path):
	data_directory = path
	self._load_story_data()


func list_files_in_directory(path):
	return _list_data_in_dir(path)['files']


func list_folders_in_directory(path):
	return _list_data_in_dir(path)['folders']


func _list_data_in_dir(path):
	var files = []
	var folders = []
	
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.begins_with("."):
				file_name = dir.get_next()
				continue
			if dir.current_is_dir():
				folders.append(file_name)
			else:
				files.append(file_name)
				print("Found file: " + file_name)
			file_name = dir.get_next()
	
	return {'files': files, 'folders': folders}


func _load_story_data():
	# Loads new game files (story and data), removes previously loaded files
	_remove_previous_resources()
	
	var story = FileAccess.open(self.data_directory + '/story.txt', FileAccess.READ)
	self.story = story.get_as_text()
	
	# get all data in directory, subdirectories are ommitted
	# TODO naming the files will be different depending on the operating mode
	# (online/offline) - in offline the name is the file name, in online
	# it will be dependent on server storage style (names containing creator etc.)

	if FileAccess.file_exists(self.data_directory + '/data'):
		for file in list_files_in_directory(self.data_directory + '/data'):
			# FIXME in actual deploy there should be no imports in data folders
			# TODO add whitelist of known filetypes and only add those
			if file.ends_with(".import"):
				continue
			
			self.loaded_resources.append(file)
			add_resource(file, load(self.data_directory + "/" + str(file)))


func _remove_previous_resources():
	for resource in self.loaded_resources:
		remove_resource(resource)