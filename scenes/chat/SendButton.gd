extends Button

onready var MessageInput = get_parent().get_child(0)
onready var MessagesContainer = get_tree().get_root().get_node("Chat").find_node("MessagesContainer")

signal send_button_pressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _pressed() -> void:
	emit_signal("send_button_pressed")
