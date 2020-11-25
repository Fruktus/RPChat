extends Control


onready var LineContainer = $LineContainer
var effects = {}

signal finished_playing


func _ready() -> void:
	set_process(false)

# will later contain full parsing mechanisms or smth
# figure out how parser will work - synchronized between all players, local to message, etc

# every message will be self-contained parsing-wise, as in at first you pass ALL
# the parameters needed to format stuff and at the end everything gets reset (to think about, maybe change)
# formatting will be done in separate function, setting up in specific objects.
# how to handle effects? i'd make an array containing all the dynamic (updatable) functions like jiggle
# and each process pass would execute every function in this array, in this way 
# ill avoid many unnecessary if statements. The functions will need to be stored in specific file that would
# match the node type, so possibly later on ill make singleton classes for each
# type of effect im going to make (text-static, text-dynamic etc)

# TODO message should also try to dynamically scale content, but we'll see about that
# proper wrapping of words would be rather hard to do efficiently, since i store
# characters as separate containers and breaking the lines would require me to calculate dynamically
# the line length and search for whitespace to break content, it may be VERY resource consuming, especially
# with a lot of messages onscreen

# TODO move regex compilation to onready


func init(text: String):
	var parsed_message_array = parse_text(text)
	var linecount = 0
	
	
	for token in parsed_message_array:
		if token is Dictionary:
			update_settings(token)
		else:
			var lines = token.split('\n')
			# if more than one line, create new box and insert, if not, then do not increment linecounter
			for line in lines:
				for character in line:
					var character_container =  preload("res://scenes/chat/assets/character.tscn").instance()
					character_container.init_effects(effects)  # TODO init_effects and storing them
					character_container.get_child(0).set_character(character)  # FIXME replace with method in character object
					$LineContainer.get_child(linecount).add_child(character_container)
				if len(lines) > 1:
					linecount += 1
					$LineContainer.add_child(HBoxContainer.new())
# TODO should the characters be hidden by default?
# or maybe as a part of dynamic effects, after initializing static text with effects,
# run the init on dynamic effects and that would take care of that

	# for testing character typing
	for i in $LineContainer.get_child(0).get_child_count():
		$LineContainer.get_child(0).get_child(i).visible = false

func parse_text(text):
	# will return array of text/commands (dicts)
	var regex = RegEx.new()
	regex.compile('(?<text>(.|\n)*?)({{(?<tag>.*?)}}|\\z)')
	
	var results = []
	for token in regex.search_all(text):
		var text_content = token.get_string('text')
		var tag_content = token.get_string('tag')
		
		if text_content:
			results.append(text_content)
		if tag_content:
			results.append(parse_tag(tag_content))
	
	return results


func parse_tag(text):
	var regex = RegEx.new()
	regex.compile('((?<key>\\S+)\\s*:\\s*(?<value>\\S+))|(?<command>\\S+)')
	
	var tag = {}
	for token in regex.search_all(text):
		var key = token.get_string('key')
		var command = token.get_string('command')
		if key:
			tag[key] = token.get_string('value')
		if command:
			# TODO maybe instead add all effects as elements of array under key 'effects'
			tag[command] = null
	
	return tag

func update_settings(new_effects: Dictionary):
	for key in new_effects:
		effects[key] = new_effects[key]

# # # # # # # # # # # # # # # # #
var time = 0.0
var ch = 0

func _process(delta: float) -> void:
	if (time + delta) > 0.01:
		time = 0
		if ch < $LineContainer.get_child(0).get_child_count():
			$LineContainer.get_child(0).get_child(ch).visible = true
			ch += 1
		else:
			# send signal that this message finished playing
			emit_signal("finished_playing")
			set_process(false)
	else:
		time += delta
