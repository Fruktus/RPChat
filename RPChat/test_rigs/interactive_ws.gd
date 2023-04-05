extends CenterContainer


@export var ws_url = "": get = my_var_get, set = my_var_set 

func my_var_set(val):
	$ServerConnector.websocket_url = val

func my_var_get():
	return $ServerConnector.websocket_url

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
