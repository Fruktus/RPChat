extends Control
class_name Message
# every message will be self-contained parsing-wise, as in at first you pass ALL
# the parameters needed to format stuff and at the end everything gets reset (to think about, maybe change)

# TODO make it so that effects parsed from within message but not meant for message (client effects)
# are ON CHANGE sent through signal. On change is important since the client should not
# modify its settings unless ordered, like its layout (because message styles need to be re-set everytime)


@onready var line_container = $MarginContainer/LineContainer

var parsed_text: Array
var t_effects = {}
var m_effects: Array  # array of funcref
var current_effect: int = -1
var current_character_idx = 0
var paused = false
var finished_playing = false

func _ready() -> void:
	set_process(false)
	self._init_message()

func _process(delta: float):
	self._apply_effects(delta)

# # # # # # # # # # #
# Public Functions  #
# # # # # # # # # # #
func init(text: String):
	# takes raw text and builds message objects composed of characters and effects tags
	self.parsed_text = Parser.parse_message(text)


func play():
	if not self.finished_playing:
		set_process(true)


func pause():
	if is_processing():
		set_process(false)
		self.paused = true
		EventBus.emit_signal("message_paused")


func resume():
	if self.paused and not self.finished_playing:
		set_process(true)
		EventBus.emit_signal("message_resumed")


func stop():
	set_process(false)
	self.finished_playing = true
	EventBus.emit_signal("message_finished_playing")


# # # # # # # # # # #
# Private Functions #
# # # # # # # # # # #
func _init_message():
	for token_idx in range(len(self.parsed_text)):
		var token = self.parsed_text[token_idx]
		if token is Dictionary:
			var tag = preload("res://components/tag/Tag.tscn").instantiate()
			tag.init(token)
			
			line_container.append(tag)
		else:
			for character_idx in range(len(token)):
				var character = token[character_idx]
				var character_container = preload("res://components/message/Character.tscn").instantiate()
				character_container.set_character(character)
				line_container.append(character_container)
				
				if character == '\n':
					if character_idx == len(token) - 1 and \
						token_idx == len(self.parsed_text) - 1:
						return
					line_container.newline()


func _update_settings(tag):
	# updates current effect settings that will be applied to the message

	for key in tag.effects:
		if 'none' in tag.effects[key]['macros']:
			self.t_effects.erase(key)
			self.m_effects.erase(key)
			continue
		
		var effect = EffectFactory.get_effect(key)
		if effect == null:
			print('unrecognized effect:', key)
			return

		if effect is T_Effect:
			effect.init(tag.effects[key])
			self.t_effects[key] = effect
		elif effect is M_Effect:
			effect.init(tag.effects[key], self)
			self.m_effects.append(effect)  # FIXME this will make overwriting existing effects hard to handle
			self.current_effect = len(self.m_effects) - 1
		elif effect is C_Effect:
			effect.init(tag.effects[key])
			EventBus.emit_signal("client_effect_added", effect)


func _apply_effects(delta: float):
	# TODO this should be a "while" loop since character_idx needs to be kept
	while self.current_character_idx < line_container.total_elements:
		var element = line_container.get_element(self.current_character_idx)
		
		# if tag, update effect settings and continue
		if element is Tag:
			self._update_settings(element)
		else:
			# apply dynamic effects
			while current_effect >= 0:
				var completed = self.m_effects[current_effect].apply(delta)
				if not completed:
					return
				if self.m_effects[current_effect].run_once():
					self.m_effects.erase(current_effect)
				current_effect -= 1

			# apply static effects
			element.init_effects(self.t_effects)  # TODO right now uses global effects var,
			element.enable()
			current_effect = len(self.m_effects) - 1
		self.current_character_idx += 1
	
	self.stop()
