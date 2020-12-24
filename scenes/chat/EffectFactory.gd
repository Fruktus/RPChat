extends Node


func _ready() -> void:
	# This may not be necessary
	set_process(false)


func get_effect(effect_name: String):
	# TODO maybe load self as dict, that gives a list of methods
	# and check if wanted method is there
	# because otherwise i'll have to create dict with mapping
	# and the function, so i'll need to update both when creating new effects
	pass

var effects = {"asd": "Asd",
				"ts_color": funcref(self, "ts_color")}

# effect(delta: float, params: dict) -> {'completed': bool, 'params': dict}

# # # # # # # # # # # #
# Text Static Effects #
# # # # # # # # # # # #
func ts_wave(amplitude, speed):
	pass


func ts_spread(amount):
	# like shake but not animated
	pass
	

func ts_shake(amount):
	pass


func ts_color(color):
	pass


# # # # # # # # # # # # #
# Text Dynamic Effects  #
# # # # # # # # # # # # #
func td_typespeed(delta: float, params = {'speed': 1.0, 'time': 0}) -> Dictionary:
	var time = params['time']
	var speed = params['speed']
	
	
	if (time + delta) > speed:
		time = 0
		return {'completed': true, 'params': params}
	else:
		params['time'] = time + delta
		return {'completed': false, 'params': params}


func td_typesfx(tone = 1.0):
	# TODO technically this should be one-time text-static
	pass

# # # # # # # # # #
# Client Effects  #
# # # # # # # # # #
# TODO possibly rename, meant to encompass bgm, layout, sprites, etc
