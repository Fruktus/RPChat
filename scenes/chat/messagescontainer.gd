extends VBoxContainer
# will turn text data into message objects
# later on it will also work on properly showing the messages - 
# when message arrives, the container will hold new messages until receiving
# signal from the one just showed that it finished playing (important for the animated ones)

var queued_messages = []
var message_playing = false

signal message_added


func _ready() -> void:
	generate_mock_messages()

func generate_mock_messages():
	# temporary, testing only
	var file = File.new()
	file.open('res://test.txt',file.READ)
	while not file.eof_reached():
		add_message(file.get_line())

func add_message(text: String):
	var message = preload("res://scenes/chat/assets/Message.tscn").instance()
	message.init(text)
	
	if not message_playing:
		message_playing = true
		self.add_child(message)
		message.connect("finished_playing", self, "_display_message")
		message.set_process(true)
		emit_signal("message_added")
	else:
		queued_messages.append(message)

# for later, when messages will be properly ordered
# not meant to be called directly
func _display_message():
	if not queued_messages.empty():
		var message = queued_messages.pop_front()
		self.add_child(message)
		message.connect("finished_playing", self, "_display_message")
		message.set_process(true)
		emit_signal("message_added")
	else:
		message_playing = false
