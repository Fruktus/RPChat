extends ScrollContainer

var scroll_manually_changed = false


func _ready():
	EventBus.connect("client_added_message", Callable(self, "on_message_added"))

func on_message_added():
	# TODO call after displaying the message or refresh from time to time or smth
	if not scroll_manually_changed:
		scroll_vertical = int(get_v_scroll_bar().max_value)
