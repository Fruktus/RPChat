extends PanelContainer
# will turn text data into message objects
# later on it will also work on properly showing the messages - 
# when message arrives, the container will hold new messages until receiving
# signal from the one just showed that it finished playing (important for the animated ones)

signal message_added

@onready var message_container = $ScrollContainer/MessageContainer
@onready var cl_dispatcher = $CLEffectDispatcher
@onready var mock_message = $ScrollContainer/MessageContainer/MockMessageLabel

var queued_messages = []
var message_playing = false




func _ready() -> void:
	mock_message.visible = false
	if Storage.story == '':
		generate_mock_messages()
	else:
		# TODO figure out how to process the story
		# since this is called in the novel context, there won't be a "message"
		# like in mp context, so maybe add novel-specific method "process_novel"
		# which would have additional parser or smth, like normal effect parsing, but
		# with markers like {{next}} for dividing messages
		var lines = Storage.story.split('\n')
		for line in lines:
			add_message(line)

func generate_mock_messages():
	# temporary, testing only
	Storage.set_data_directory("res://examples/demo")
	var story = FileAccess.open('res://examples/demo/story.txt', FileAccess.READ)
	var lines = story.get_as_text().split('\n')
	
	for line in lines:
		add_message(line)


func add_message(text: String):
	var message = preload("res://components/message/Message.tscn").instantiate()
	message.connect("cd_effect", Callable(cl_dispatcher, "on_effect"))
	message.init(text)
	
	if not message_playing:
		message_playing = true
		message_container.add_child(message)
		message.connect("finished_playing", Callable(self, "_display_message"))
		message.set_process(true)
		emit_signal("message_added")
	else:
		queued_messages.append(message)


# for later, when messages will be properly ordered
# not meant to be called directly
func _display_message():
	if not queued_messages.is_empty():
		var message = queued_messages.pop_front()
		message_container.add_child(message)
		message.connect("finished_playing", Callable(self, "_display_message"))
		message.set_process(true)
		emit_signal("message_added")
	else:
		message_playing = false


func on_effect(effect):
	pass # Replace with function body.
