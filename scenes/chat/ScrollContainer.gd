extends ScrollContainer

var scroll_manually_changed = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_message_added():
	# TODO call after displaying the message or refresh from time to time or smth
	if not scroll_manually_changed:
		scroll_vertical = get_v_scrollbar().max_value
