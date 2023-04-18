extends PanelContainer
# will turn text data into message objects
# later on it will also work on properly showing the messages - 
# when message arrives, the container will hold new messages until receiving
# signal from the one just showed that it finished playing (important for the animated ones)

signal message_added
signal user_interaction  # Emitted when user clicks or keypresses the window

@onready var message_container = $ScrollContainer/MessageContainer
@onready var cl_dispatcher = $CLEffectDispatcher
@onready var bgm_player = $BGMPlayer
@onready var bg_image = $BGImage

var queued_messages = []
var message_playing = false
var c_effects = []  # For the effects that get applied continuously



func _ready() -> void:
	self.clear_messages()

	if not Storage.story_loaded:
		generate_mock_messages()
	else:
		# TODO figure out how to process the story
		# since this is called in the novel context, there won't be a "message"
		# like in mp context, so maybe add novel-specific method "process_novel"
		# which would have additional parser or smth, like normal effect parsing, but
		# with markers like {{next}} for dividing messages
		self._load_messages_from_string(Storage.story)


func generate_mock_messages():
	# Reads the demo story and loads it. The demo is meant to show all effects and can be used for testing
	Storage.set_data_directory("res://examples/demo")
	var story = FileAccess.open('res://examples/demo/story.txt', FileAccess.READ)
	self._load_messages_from_string(story.get_as_text())


func add_message(text: String):
	# Takes the text and parses it into message, adds it to message_container
	var message = preload("res://components/message/Message.tscn").instantiate()
	message.connect("c_effect", Callable(self, "on_effect"))
	message.init(text)
	
	if not message_playing:
		message_playing = true
		self._play_message(message)
	else:
		queued_messages.append(message)


func clear_messages():
	# Removes all messages currently added
	for child in message_container.get_children():
		message_container.remove_child(child)
		child.queue_free()


func on_effect(effect: C_Effect):
	# TODO decide what exactly can each of the types affect (what gets passed)
	# for ex image should get access to bg which can contain sprite, but it
	# should not be allowed to modify layout.
	# If both are desired, then multiple effects should be chained
	match effect.type():
		C_Effect.Type.AUDIO:
			# The effect gets applied once, receives BGMPlayer as a parameter
			bgm_player.on_effect(effect)  # TODO - implement it other way around - effect.apply(bgm_player)
		C_Effect.Type.IMAGE:
			# The effect gets applied once, receives BGSprite as a parameter
			effect.apply(bg_image)
		C_Effect.Type.MESSAGE:
			# The effect is either applied once or applied continously,
			# depending on its run_once setting
			# It receives newly added message as param (before it is executed)
			# If it is set to false then the effect gets added to c_effect
			# and is ran every time new message is added
			pass
		C_Effect.Type.CLIENT:
			self.c_effects.append(effect)


func on_interaction():
	pass


#func _gui_input(event):
#	print('guiinput', event)
#
#func _input(event):
#	print('input', event)

func _load_messages_from_string(story: String):
	var lines = story.split('\n')
	var message = ''
	
	for line_idx in range(len(lines)):
		if lines[line_idx] == '':
			add_message(message)
			message = ''
		else:
			message += lines[line_idx] + '\n'



func _play_message(message):
	if len(self.c_effects) > 0:
		for effect in c_effects:
			effect.apply(self)
	
	message_container.add_child(message)
	message.connect("finished_playing", Callable(self, "_dequeue_next_message"))
	message.set_process(true)
	emit_signal("message_added")

# for later, when messages will be properly ordered
# not meant to be called directly
func _dequeue_next_message():
	# Signalled from messages when they finish playing so that next one can load (if queued)
	if not queued_messages.is_empty():
		var message = queued_messages.pop_front()
		self._play_message(message)
	else:
		message_playing = false
