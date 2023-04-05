extends Button

signal send_data(data)

func _pressed() -> void:
	var text = get_parent().get_child(0).text
	if len(text) > 0:
		get_parent().get_child(0).text = ''
		emit_signal("send_data", text)
