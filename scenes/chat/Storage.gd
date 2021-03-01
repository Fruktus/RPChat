extends ResourcePreloader

var data_directory: String setget data_directory_set



func _ready():
	set_process(false)
	
	# FIXME testing only:
	self.data_directory = "res://examples/story1"


func data_directory_set(path):
	data_directory = path
	self._load_data()


func list_files_in_directory(path):
	var files = []
	var dir = Directory.new()
	dir.open(path + '/data')
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with(".") and not dir.current_is_dir():
			files.append(file)

	dir.list_dir_end()

	return files


func _load_data():
	# get all data in directory, subdirectories are ommitted
	# TODO naming the files will be different depending on the operating mode
	# (online/offline) - in offline the name is the file name, in online
	# it will be dependent on server storage style (names containing creator etc.)
	for file in list_files_in_directory(self.data_directory):  # FIXMEFIXME in actual deploy there should be no imports in data folders
		if file.ends_with(".import"):
			continue
		add_resource(file, load(self.data_directory + "/data/" + str(file)))
