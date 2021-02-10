extends Control


var effects = {}
var td_effects: Array  # array of funcref
var final_effect: FuncRef
var current_effect: int = 0

signal finished_playing


func _ready() -> void:
	set_process(false)

# every message will be self-contained parsing-wise, as in at first you pass ALL
# the parameters needed to format stuff and at the end everything gets reset (to think about, maybe change)

# formatting will be done in separate function, setting up in specific objects.

# how to handle effects? i'd make an array containing all the dynamic (updatable) functions like jiggle
# and each process pass would execute every function in this array, in this way 
# ill avoid many unnecessary if statements. The functions will need to be stored in specific file that would
# match the node type, so possibly later on ill make singleton classes for each
# type of effect im going to make (text-static, text-dynamic etc)

# TODO make it so that effects parsed from within message but not meant for message (client effects)
# are ON CHANGE sent through signal. On change is important since the client should not
# modify its settings unless ordered, like its layout (because message styles need to be re-set everytime)



func init(text: String):
	# takes raw text and builds message objects composed of characters and effects tags
	var parsed_message_array = parse_text(text)
	
	for token in parsed_message_array:
		if token is Dictionary:
			var tag =  preload("res://scenes/chat/assets/Tag.tscn").instance()
			tag.init(token)
			
			$LineContainer.append(tag)
		else:
			for character in token:
				if character == '\n':
					$LineContainer.newline()
					continue
					
				var character_container = preload("res://scenes/chat/assets/Character.tscn").instance()
				character_container.set_character(character)
				$LineContainer.append(character_container)

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

func update_settings(tag):
	# meant to change the way new characters are set up
	# TODO should grab new effects from effect factory
	
	for key in tag.effects:
		# if key in effects:
		#     del effects[key]
		var effect = EffectFactory.get_effect(key)
		var eff2 = effect.instance()
		effect.init(tag.effects)
		# and then
#		effects.append(effect)
		
		
		# TODO this is used for coloring text at the moment, but should be removed
		# when effect generation is complete
#		effects[key] = tag.effects[key]
		self.effects[key] = effect

# work in progress, effect application mechanism
func _apply_effects(delta: float):
	# TODO this should be a "while" loop since character_idx needs to be kept
	for character_idx in range($LineContainer.total_elements):
		var element = $LineContainer.get_element(character_idx)
		
		# First, check if the processed character is a tag, if it is then just update
		# the effect table and continue
		if element.get_class() == "Control":
			update_settings(element)
		else:
			# else:  # not a tag, so apply effects
			# apply dynamic effects
			while current_effect < len(td_effects):
				var res = td_effects[current_effect].call(delta)  # res[0] = completion, res[1] = params
				if not res['completed']:
					return
				current_effect += 1
			
			# apply static effects
			element.init_effects(effects)  # TODO right now uses global effects var,
			# should have separate tables for different effects
			
	#		final_effect.call_func(character)
			element.enable()
	emit_signal("finished_playing")
	set_process(false)

func _process(delta: float):
	_apply_effects(delta)
