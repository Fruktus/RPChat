extends ScrollContainer

var scroll_manually_changed = false


func _on_message_added():
	# TODO call after displaying the message or refresh from time to time or smth
	if not scroll_manually_changed:
		scroll_vertical = get_v_scroll_bar().max_value
