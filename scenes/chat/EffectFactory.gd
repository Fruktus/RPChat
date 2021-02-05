extends Node


func _ready() -> void:
	# This may not be necessary
	set_process(false)


func get_effect(effect_name: String):
	if effect_name in self.effects:
		var effect_class = load(self.effects[effect_name])
		return effect_class.new()
		
	return null  # FIXME should be done in some nicer way, like return empty or false

var effects = {"asd": "Asd",
				"ts_color": "res://scenes/chat/effects/text_static/ts_color.gd",
				"ts_shake": "res://scenes/chat/effects/text_static/ts_shake.gd",
				"template": "res://lion.gd"}

# effect(delta: float, params: dict) -> {'completed': bool, 'params': dict}

# # # # # # # # # # # #
# Text Static Effects #
# # # # # # # # # # # #
func ts_wave(params):
	pass


func ts_spread(params):
	# like shake but not animated
	pass
	

func ts_shake(params):
	pass


func ts_color(params):
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
