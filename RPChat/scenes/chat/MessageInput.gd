extends TextEdit

var min_line_height: int = 30  # defines size of single line

signal send_text(message_text)


func _send_text():
	if text:
#		MessagesContainer.add_message(MessageInput.text)
#		MessageInput.text = ''
		emit_signal("send_text", text)


func _on_Control_text_changed():
	size.y = get_line_count()*min_line_height


func _input(event: InputEvent) -> void:
	# TODO figure out how to not type newline on enter keypress
	if event is InputEventKey and event.keycode == KEY_ENTER and not event.control and get_line_count() == 2:
		_send_text()
		text = ''
		get_viewport().set_input_as_handled()  # consume the event so it will  not get spread to editbox


# TODEL part of input spike, probably not necessary anymore
#func _unhandled_input(ev):
#	if ev.scancode == KEY_ENTER and not ev.control and get_line_count() == 2:
#		text = ''
#		print('sending')


