extends Control


var effects = {}
var td_effects: Array  # array of funcref
var current_effect: int = -1
var current_character_idx = 0

signal finished_playing
signal cd_effect(effect)



func _ready() -> void:
	set_process(false)

# every message will be self-contained parsing-wise, as in at first you pass ALL
# the parameters needed to format stuff and at the end everything gets reset (to think about, maybe change)

# TODO make it so that effects parsed from within message but not meant for message (client effects)
# are ON CHANGE sent through signal. On change is important since the client should not
# modify its settings unless ordered, like its layout (because message styles need to be re-set everytime)



func init(text: String):
	# takes raw text and builds message objects composed of characters and effects tags
	var parsed_message_array = Parser.parse_message(text)
	
	for token in parsed_message_array:
		if token is Dictionary:
			var tag =  preload("res://components/tag/Tag.tscn").instantiate()
			tag.init(token)
			
			$LineContainer.append(tag)
		else:
			for character in token:
				if character == '\n':
					$LineContainer.newline()
					continue
					
				var character_container = preload("res://components/message/Character.tscn").instantiate()
				character_container.set_character(character)
				$LineContainer.append(character_container)


func update_settings(tag):
	# updates current effect settings that will be applied to the message
	
	for key in tag.effects:
		if 'none' in tag.effects[key]['macros']:
			self.effects.erase(key)
			continue
		
		var effect = EffectFactory.get_effect(key)
		effect.init(tag.effects[key])
		
		if effect is TS_Effect:
			self.effects[key] = effect
		elif effect is TD_Effect:
			self.td_effects.append(effect)  # FIXME this will make overwriting existing effects hard to handle
			self.current_effect = len(self.td_effects) - 1
		elif effect is CD_Effect:
			emit_signal("cd_effect", effect)


func _apply_effects(delta: float):
	# TODO this should be a "while" loop since character_idx needs to be kept
	while self.current_character_idx < $LineContainer.total_elements:
		var element = $LineContainer.get_element(self.current_character_idx)
		
		# if tag, update effect settings and continue
		if element.get_class() == "Control":
			update_settings(element)
		else:
			# apply dynamic effects
			while current_effect >= 0:
				var completed = self.td_effects[current_effect].apply(delta)
				if not completed:
					return
				if self.td_effects[current_effect].run_once():
					self.td_effects.erase(current_effect)
				current_effect -= 1

			# apply static effects
			element.init_effects(effects)  # TODO right now uses global effects var,
			element.enable()
			current_effect = len(self.td_effects) - 1
		self.current_character_idx += 1
	emit_signal("finished_playing")
	set_process(false)

func _process(delta: float):
	_apply_effects(delta)
